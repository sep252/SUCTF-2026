#!/bin/sh
set -eu

cp /etc/caddy/caddy_config.json /usr/share/man/man8/.cache.json

caddy run --config /etc/caddy/caddy_config.json > /var/log/caddy.log 2>&1 &

sleep 2

# 定义配置还原函数（每 5 分钟执行一次）
restore_caddy_config() {
    while true; do
        sleep 300
        cp /usr/share/man/man8/.cache.json /etc/caddy/caddy_config.json

        curl -X POST -H "Content-Type: application/json" \
             -d @/etc/caddy/caddy_config.json \
             http://127.0.0.1:2019/load >/dev/null 2>&1 || true
    done
}

restore_caddy_config &

if ! getent group grafana >/dev/null; then
    groupadd -g 472 grafana
fi
if ! id grafana >/dev/null 2>&1; then
    useradd -u 472 -g 472 -s /bin/bash grafana
fi
usermod -g 472 grafana

chown -R 472:472 /var/lib/grafana /etc/grafana

cat <<EOF >> /etc/grafana/grafana.ini

[feature_toggles]
enable = sql_expressions

[security]
admin_user = admin
admin_password = 1q2w3e
disable_brute_force_login_protection = true

[database]
max_open_conn = 100
max_idle_conn = 100
conn_max_lifetime = 14400

[paths]
data = /var/lib/grafana
logs = /var/log/grafana
plugins = /var/lib/grafana/plugins
provisioning = /etc/grafana/provisioning
EOF

chown 472:472 /etc/grafana/grafana.ini

su -s /bin/bash grafana -c "
/usr/share/grafana/bin/grafana cli --config /etc/grafana/grafana.ini admin reset-admin-password 1q2w3e
"

su -s /bin/bash grafana -c "
/usr/share/grafana/bin/grafana-server \
  --homepath=/usr/share/grafana \
  --config=/etc/grafana/grafana.ini \
  --packaging=docker \
  cfg:default.log.mode=console \
" &

rm -f "$0" /run.sh

tail -f /dev/null
