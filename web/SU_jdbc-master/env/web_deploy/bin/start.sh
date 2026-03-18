#!/bin/bash
cd /app
java -Djava.security.manager -Djava.security.policy=/app/no-outbound.policy -jar app.jar &
sleep infinity
