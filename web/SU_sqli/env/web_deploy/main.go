package main

import (
	"context"
	"embed"
	"encoding/json"
	"io"
	"io/fs"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"

	"su_sqli/internal/sign"
	"su_sqli/internal/waf"
)

//go:embed web/templates/index.html
var indexHTML []byte

//go:embed web/static/*
var staticFS embed.FS

type server struct {
	pool   *pgxpool.Pool
	secret []byte
	nonces *sign.NonceStore
}

type queryReq struct {
	Q     string `json:"q"`
	Nonce string `json:"nonce"`
	Ts    int64  `json:"ts"`
	Sign  string `json:"sign"`
}

type queryRow struct {
	ID    int    `json:"id"`
	Title string `json:"title"`
}

type apiResp struct {
	OK    bool        `json:"ok"`
	Error string      `json:"error,omitempty"`
	Data  interface{} `json:"data,omitempty"`
}

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	dsn := os.Getenv("DATABASE_URL")
	if dsn == "" {
		dsn = "postgres://postgres:postgres@127.0.0.1:5432/ctf?sslmode=disable"
	}

	pool, err := pgxpool.New(context.Background(), dsn)
	if err != nil {
		log.Fatalf("db connect failed: %v", err)
	}
	defer pool.Close()

	srv := &server{
		pool:   pool,
		secret: sign.SecretFromEnv(),
		nonces: sign.NewNonceStore(60 * time.Second),
	}

	staticSub, err := fs.Sub(staticFS, "web/static")
	if err != nil {
		log.Fatalf("static fs: %v", err)
	}

	mux := http.NewServeMux()
	mux.HandleFunc("/", srv.handleIndex)
	mux.Handle("/static/", http.StripPrefix("/static/", http.FileServer(http.FS(staticSub))))
	mux.HandleFunc("/api/sign", srv.handleSign)
	mux.HandleFunc("/api/query", srv.handleQuery)

	log.Printf("listening on :%s", port)
	if err := http.ListenAndServe(":"+port, logMiddleware(mux)); err != nil {
		log.Fatal(err)
	}
}

func (s *server) handleIndex(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		http.NotFound(w, r)
		return
	}
	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	w.WriteHeader(http.StatusOK)
	_, _ = w.Write(indexHTML)
}

func (s *server) handleSign(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodGet {
		w.WriteHeader(http.StatusMethodNotAllowed)
		return
	}
	nonce, ts, salt, err := s.nonces.Issue()
	if err != nil {
		writeJSON(w, http.StatusInternalServerError, apiResp{OK: false, Error: "nonce"})
		return
	}
	ua := r.UserAgent()
	seed, err := sign.SeedPackFor(nonce, ts, ua, salt, s.secret)
	if err != nil {
		writeJSON(w, http.StatusInternalServerError, apiResp{OK: false, Error: "seed"})
		return
	}
	payload := map[string]interface{}{
		"nonce": nonce,
		"ts":    ts,
		"seed":  seed,
		"salt":  salt,
		"algo":  "v6",
	}
	w.Header().Set("Cache-Control", "no-store")
	writeJSON(w, http.StatusOK, apiResp{OK: true, Data: payload})
}

func (s *server) handleQuery(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		w.WriteHeader(http.StatusMethodNotAllowed)
		return
	}
	body, err := io.ReadAll(io.LimitReader(r.Body, 1<<20))
	if err != nil {
		writeJSON(w, http.StatusBadRequest, apiResp{OK: false, Error: "bad body"})
		return
	}
	var req queryReq
	if err := json.Unmarshal(body, &req); err != nil {
		writeJSON(w, http.StatusBadRequest, apiResp{OK: false, Error: "bad json"})
		return
	}
	if req.Q == "" || req.Nonce == "" || req.Ts == 0 || req.Sign == "" {
		writeJSON(w, http.StatusBadRequest, apiResp{OK: false, Error: "missing"})
		return
	}
	salt, ok := s.nonces.Consume(req.Nonce, req.Ts)
	if !ok {
		writeJSON(w, http.StatusUnauthorized, apiResp{OK: false, Error: "nonce"})
		return
	}
	ua := r.UserAgent()
	expected, err := sign.Sign("POST", "/api/query", req.Q, req.Nonce, req.Ts, ua, salt, s.secret)
	if err != nil || !sign.Verify(expected, req.Sign) {
		writeJSON(w, http.StatusUnauthorized, apiResp{OK: false, Error: "bad sign"})
		return
	}
	if waf.Blocked(req.Q) {
		writeJSON(w, http.StatusForbidden, apiResp{OK: false, Error: "blocked"})
		return
	}

	sql := "SELECT id, title FROM posts WHERE status='public' AND title ILIKE '%" + req.Q + "%' LIMIT 20"
	ctx, cancel := context.WithTimeout(r.Context(), 3*time.Second)
	defer cancel()

	rows, err := s.pool.Query(ctx, sql)
	if err != nil {
		writeJSON(w, http.StatusOK, apiResp{OK: false, Error: err.Error()})
		return
	}
	defer rows.Close()

	results := make([]queryRow, 0)
	for rows.Next() {
		var row queryRow
		if err := rows.Scan(&row.ID, &row.Title); err != nil {
			writeJSON(w, http.StatusOK, apiResp{OK: false, Error: err.Error()})
			return
		}
		results = append(results, row)
	}
	if rows.Err() != nil {
		writeJSON(w, http.StatusOK, apiResp{OK: false, Error: rows.Err().Error()})
		return
	}

	writeJSON(w, http.StatusOK, apiResp{OK: true, Data: results})
}

func writeJSON(w http.ResponseWriter, status int, payload apiResp) {
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	w.WriteHeader(status)
	enc := json.NewEncoder(w)
	_ = enc.Encode(payload)
}

func logMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()
		next.ServeHTTP(w, r)
		log.Printf("%s %s %s", r.Method, r.URL.Path, time.Since(start))
	})
}
