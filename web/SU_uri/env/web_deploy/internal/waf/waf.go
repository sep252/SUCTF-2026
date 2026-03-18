package waf

import (
	"fmt"
	"net"
	"net/netip"
	"net/url"
	"strings"
)

var blockedIPv4Ranges = []netip.Prefix{
	netip.MustParsePrefix("0.0.0.0/8"),
	netip.MustParsePrefix("127.0.0.0/8"),
	netip.MustParsePrefix("10.0.0.0/8"),
	netip.MustParsePrefix("172.16.0.0/12"),
	netip.MustParsePrefix("192.168.0.0/16"),
	netip.MustParsePrefix("169.254.0.0/16"),
	netip.MustParsePrefix("100.64.0.0/10"),
}

var blockedIPv6Ranges = []netip.Prefix{
	netip.MustParsePrefix("::1/128"),
	netip.MustParsePrefix("fc00::/7"),
	netip.MustParsePrefix("fe80::/10"),
}

func ValidateURL(rawURL string) error {
	parsed, err := url.Parse(rawURL)
	if err != nil {
		return fmt.Errorf("invalid URL: %w", err)
	}

	if parsed.Scheme != "http" && parsed.Scheme != "https" {
		return fmt.Errorf("unsupported scheme: %s", parsed.Scheme)
	}

	host := parsed.Hostname()
	if host == "" {
		return fmt.Errorf("missing host")
	}
	if strings.EqualFold(host, "localhost") {
		return fmt.Errorf("blocked host: localhost")
	}

	// DNS is resolved during validation time only.
	ips, err := net.LookupIP(host)
	if err != nil {
		return fmt.Errorf("resolve failed: %w", err)
	}
	if len(ips) == 0 {
		return fmt.Errorf("resolve failed: empty result")
	}

	for _, ip := range ips {
		addr, ok := netip.AddrFromSlice(ip)
		if !ok {
			return fmt.Errorf("invalid resolved IP: %s", ip.String())
		}
		// Normalize IPv4-mapped IPv6 (e.g. ::ffff:127.0.0.1) to IPv4
		// before range checks to avoid local-address bypasses.
		if addr.Is4In6() {
			addr = addr.Unmap()
		}
		if isBlockedIP(addr) {
			return fmt.Errorf("blocked IP: %s", addr.String())
		}
	}
	return nil
}

func isBlockedIP(ip netip.Addr) bool {
	// Explicitly block local/special addresses and mapped forms.
	if ip.Is4In6() {
		ip = ip.Unmap()
	}
	if ip.IsLoopback() || ip.IsUnspecified() || ip.IsLinkLocalUnicast() || ip.IsLinkLocalMulticast() {
		return true
	}

	var ranges []netip.Prefix
	if ip.Is4() {
		ranges = blockedIPv4Ranges
	} else {
		ranges = blockedIPv6Ranges
	}
	for _, p := range ranges {
		if p.Contains(ip) {
			return true
		}
	}
	return false
}
