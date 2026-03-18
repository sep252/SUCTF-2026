FROM tomcat:8.5-jdk8-temurin

ARG MYSQL_HOST=mysql

# Run the service as an unprivileged user (not root).
RUN set -eux; \
    groupadd -r wms; \
    useradd -r -g wms -d /home/wms -m -s /usr/sbin/nologin wms; \
    chown -R wms:wms /usr/local/tomcat

# Deploy the exploded `jeewms/` tree so the repo stays below GitHub's
# single-file limit while preserving the original app contents.
COPY jeewms/ /tmp/jeewms/

RUN set -eux; \
    rm -rf /usr/local/tomcat/webapps/*; \
    sed -i "s|127.0.0.1|${MYSQL_HOST}|g" /tmp/jeewms/WEB-INF/classes/dbconfig.properties; \
    sed -i "s|127.0.0.1|${MYSQL_HOST}|g" /tmp/jeewms/WEB-INF/classes/jeecg/jeecg_database.properties; \
    sed -i 's/^password=.*/password=123456/' /tmp/jeewms/WEB-INF/classes/jeecg/jeecg_database.properties; \
    mv /tmp/jeewms /usr/local/tomcat/webapps/jeewms

# Put flag under a random path + random filename at image build time.
COPY flag /tmp/flag
RUN set -eux; \
    FLAG_DIR="$(cat /proc/sys/kernel/random/uuid | tr -d '-' | cut -c1-12)"; \
    FLAG_NAME="flag_$(cat /proc/sys/kernel/random/uuid | tr -d '-' | cut -c1-8)"; \
    mkdir -p "/${FLAG_DIR}"; \
    mv /tmp/flag "/${FLAG_DIR}/${FLAG_NAME}"; \
    chmod 400 "/${FLAG_DIR}/${FLAG_NAME}"; \
    chmod u+s /bin/date; \
    chown -R wms:wms /usr/local/tomcat

EXPOSE 8080

USER wms
