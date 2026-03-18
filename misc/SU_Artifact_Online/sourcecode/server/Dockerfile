FROM python:3.10.12-slim-bullseye

LABEL auther_template="CTF-Archives"

# apt mirror + update
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update

# Install socat (PTY allocation needed for real-time arrow-key input)
RUN apt-get install -y socat

# Deploy entrypoint
COPY ./service/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Create user
RUN useradd -m ctf
WORKDIR /home/ctf

# Deploy program
COPY ./src/server.py /home/ctf/server.py
RUN chown root:root /home/ctf/server.py && chmod 700 /home/ctf/server.py

# Deploy flag (static, ctf user read-only)
COPY ./flag /home/flag
RUN chown root:ctf /home/flag && chmod 440 /home/flag

EXPOSE 9999

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]
