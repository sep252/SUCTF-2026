FROM ubuntu:20.04

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    MB9_DEBUG=0

RUN apt-get update && \
    apt-get install -y --no-install-recommends xinetd python3 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash ctf

WORKDIR /home/ctf

COPY ./ctf.xinetd /etc/xinetd.d/ctf
COPY ./start.sh /start.sh
RUN echo "Blocked by ctf_xinetd" > /etc/banner_fail

# Runtime-only packaging:
# ship only the protocol service app and fallback flag file.
COPY ./bin/mb9/app/ /home/ctf/mb9/app/
COPY ./bin/flag /home/ctf/flag
RUN sed -i '1s/^\xEF\xBB\xBF//' /start.sh && \
    sed -i 's/\r$//' /start.sh /etc/xinetd.d/ctf && \
    chmod +x /start.sh && \
    chmod +x /home/ctf/mb9/app/main.py && \
    find /home/ctf -type d -name '__pycache__' -prune -exec rm -rf {} + && \
    chown -R root:ctf /home/ctf && \
    chmod -R 750 /home/ctf && \
    chmod 640 /home/ctf/flag

CMD ["/start.sh"]

EXPOSE 9999
