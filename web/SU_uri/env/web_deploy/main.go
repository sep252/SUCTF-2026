package main

import (
	"encoding/json"
	"log"
	"net/http"
	"time"

	"cloudhook-service/internal/bot"
	"cloudhook-service/internal/waf"
)

type webhookRequest struct {
	URL  string `json:"url"`
	Body string `json:"body"`
}

type webhookResponse struct {
	Message      string `json:"message"`
	TargetStatus int    `json:"target_status,omitempty"`
	TargetBody   string `json:"target_body,omitempty"`
}

func main() {
	mux := http.NewServeMux()
	client := bot.NewClient()

	mux.HandleFunc("/api/webhook", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			writeJSON(w, http.StatusMethodNotAllowed, webhookResponse{Message: "method not allowed"})
			return
		}

		var req webhookRequest
		if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
			writeJSON(w, http.StatusBadRequest, webhookResponse{Message: "invalid JSON payload"})
			return
		}
		if req.URL == "" {
			writeJSON(w, http.StatusBadRequest, webhookResponse{Message: "url is required"})
			return
		}

		if err := waf.ValidateURL(req.URL); err != nil {
			writeJSON(w, http.StatusBadRequest, webhookResponse{Message: err.Error()})
			return
		}

		// Simulate async deep inspection work before dispatching the outbound webhook.
		time.Sleep(2 * time.Second)

		status, body, err := client.Post(req.URL, req.Body)
		if err != nil {
			writeJSON(w, http.StatusBadGateway, webhookResponse{Message: err.Error()})
			return
		}

		writeJSON(w, http.StatusOK, webhookResponse{
			Message:      "forwarded",
			TargetStatus: status,
			TargetBody:   body,
		})
	})

	mux.Handle("/", http.FileServer(http.Dir("./static")))

	server := &http.Server{
		Addr:    ":8080",
		Handler: mux,
	}

	log.Println("CloudHook-Service listening on :8080")
	if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		log.Fatalf("server error: %v", err)
	}
}

func writeJSON(w http.ResponseWriter, status int, payload webhookResponse) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	_ = json.NewEncoder(w).Encode(payload)
}
