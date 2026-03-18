#!/bin/bash
set -euo pipefail

# 模板化基础版本。
# 当前 SU_uri 题目为静态 flag 方案（readflag.c 编码 + setup 生成 readflag），
# 本脚本未真正接入漏洞链路中的动态 flag 注入。

if [ $# -lt 1 ]; then
  echo "usage: $0 'flag{...}'" >&2
  exit 1
fi

FLAG_VALUE="$1"
echo "$FLAG_VALUE" > /flag

echo "[NOTICE] 当前题目默认静态 flag；script/pushflag.sh 仅模板基础版本，未完成真实接入。"
