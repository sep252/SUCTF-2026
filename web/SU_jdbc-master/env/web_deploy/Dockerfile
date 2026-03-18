FROM eclipse-temurin:8-jdk

WORKDIR /app

COPY  bin/ /tmp/bin/

RUN cp -r /tmp/bin/src/. /app/ && \
    cp /tmp/bin/config/no-outbound.policy /app/no-outbound.policy && \
    cp /tmp/bin/flag /flag && \
    cp /tmp/bin/start.sh /

RUN rm -rf /tmp/bin/

RUN chmod +x /start.sh

CMD ["sh", "-c", "/start.sh"]
EXPOSE 8080
