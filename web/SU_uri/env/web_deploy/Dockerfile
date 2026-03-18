FROM golang:1.22-alpine AS builder
WORKDIR /src

RUN apk add --no-cache build-base

COPY go.mod ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags="-s -w" -o /out/cloudhook-service .
RUN gcc -static -O2 -s -o /out/readflag /src/setup/readflag.c

FROM alpine:3.20
WORKDIR /app

RUN apk add --no-cache ca-certificates socat curl su-exec \
	&& addgroup -g 1000 -S ctfer \
	&& adduser -u 1000 -S -D -H -G ctfer ctfer

COPY --from=builder /out/cloudhook-service /app/cloudhook-service
COPY --from=builder /out/readflag /app/readflag
COPY --from=builder /src/static /app/static
COPY entrypoint.sh /entrypoint.sh
COPY ./bin/start.sh /start.sh
COPY ./bin/pushflag.sh /pushflag.sh
COPY ./bin/flag /flag

RUN chmod 0755 /entrypoint.sh /start.sh /pushflag.sh /app/readflag

EXPOSE 8080

ENTRYPOINT ["/start.sh"]
