package waf

import "regexp"

var re = regexp.MustCompile(`(?i)(--|/\*|\*/|;|\bunion\b|\bor\b|\band\b|\bpg_sleep\b|\bpg_read_file\b|\bcopy\b|\blo_\b|\bcurrent_setting\b|\binformation_schema\b|\bpg_catalog\b|\bto_number\b|\bcast\b|::|\bchr\b|\bencode\b|\bdecode\b|\b1\s*/\s*0\b)`)

func Blocked(input string) bool {
	if len(input) > 256 {
		return true
	}
	return re.MatchString(input)
}
