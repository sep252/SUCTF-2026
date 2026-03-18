#!/bin/bash
set -euo pipefail

# 模板化基础版本（Web 默认可写 /flag）。
# 注意：当前 SU_sqli 实际 flag 仍静态写在 db/init.sql，
# 本脚本尚未真正接入题目动态 flag 注入流程。

if [ $# -lt 1 ]; then
  echo "usage: $0 'flag{...}'" >&2
  exit 1
fi

FLAG_VALUE="$1"

# 基础写法：写入 /flag（仅模板示例，是否被题目逻辑消费需人工确认）
echo "$FLAG_VALUE" > /flag

# 若需真正接入当前题目，请人工补充 DB 更新逻辑，例如：
# psql "$DATABASE_URL" -c "UPDATE secrets SET flag='${FLAG_VALUE}' WHERE id=1;"

echo "[NOTICE] 当前题目默认静态 flag（db/init.sql）；pushflag 仅为模板基础版本，未完成真实接入。"
