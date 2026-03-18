FROM grafana/grafana:11.0.0-ubuntu

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget unzip curl \
    && rm -rf /var/lib/apt/lists/*

COPY caddy_2.8.4_linux_amd64.tar.gz /tmp/caddy.tar.gz
COPY duckdb_cli-linux-amd64.zip /tmp/duckdb_cli-linux-amd64.zip
RUN tar -xzf /tmp/caddy.tar.gz -C /usr/bin/ caddy \
    && rm /tmp/caddy.tar.gz \
    && chmod +x /usr/bin/caddy \
    && unzip /tmp/duckdb_cli-linux-amd64.zip -d /usr/local/bin/ \
    && rm /tmp/duckdb_cli-linux-amd64.zip \
    && chmod +x /usr/local/bin/duckdb \
    && echo "SUCTF{c4ddy_4dm1n_4p1_2019_pr1v35c}" > /root/flag \
    && chmod 600 /root/flag

COPY caddy_config.json /etc/caddy/caddy_config.json

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80

ENTRYPOINT ["/start.sh"]
