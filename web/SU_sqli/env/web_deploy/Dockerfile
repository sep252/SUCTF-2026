FROM golang:1.21-alpine AS build
WORKDIR /app
ENV GOPROXY=https://proxy.golang.org,direct
ENV GOSUMDB=sum.golang.org
ENV GOFLAGS=-mod=mod
COPY go.mod ./
RUN go mod download
COPY . ./
RUN go mod tidy
RUN CGO_ENABLED=0 go build -o /bin/su_sqli .

FROM postgres:17
WORKDIR /app
COPY --from=build /bin/su_sqli /app/server
COPY ./db/init.sql /docker-entrypoint-initdb.d/init.sql
COPY ./bin/start.sh /start.sh
COPY ./bin/pushflag.sh /pushflag.sh
COPY ./bin/flag /flag
RUN chmod +x /start.sh /pushflag.sh && \
    chown postgres:postgres /docker-entrypoint-initdb.d/init.sql
EXPOSE 8080
ENV PORT=8080 \
    POSTGRES_DB=ctf \
    POSTGRES_USER=postgres \
    POSTGRES_PASSWORD=postgres
CMD ["bash", "-c", "/start.sh"]
