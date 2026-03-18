#!/bin/bash

# 获取当前 ISO 8601 格式时间戳
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

git add .
git commit -m "Archive Update: $timestamp"

# 确保分支名为 main 并推送到远程
git branch -M main
git push origin main --force
