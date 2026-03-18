package bot

import (
	"bytes"
	"fmt"
	"io"
	"net/http"
	"time"
)

type Client struct {
	httpClient *http.Client
}

func NewClient() *Client {
	return &Client{
		httpClient: &http.Client{
			Timeout: 10 * time.Second,
			// Do not follow redirects; this service only forwards to the exact user URL.
			CheckRedirect: func(req *http.Request, via []*http.Request) error {
				return http.ErrUseLastResponse
			},
		},
	}
}

func (c *Client) Post(targetURL string, body string) (int, string, error) {
	req, err := http.NewRequest(http.MethodPost, targetURL, bytes.NewBufferString(body))
	if err != nil {
		return 0, "", fmt.Errorf("build outbound request failed: %w", err)
	}
	req.Header.Set("Content-Type", "application/json")

	resp, err := c.httpClient.Do(req)
	if err != nil {
		return 0, "", fmt.Errorf("forward request failed: %w", err)
	}
	defer resp.Body.Close()

	respBody, err := io.ReadAll(io.LimitReader(resp.Body, 64*1024))
	if err != nil {
		return 0, "", fmt.Errorf("read target response failed: %w", err)
	}

	return resp.StatusCode, string(respBody), nil
}
