# SU_EzRouter

## 本地复现

- 进入 `firmware/`
- 执行 `docker build -t su_ezrouter .`
- 执行 `docker run --rm -p 80:80 su_ezrouter`

## 归档说明

- 仓库保留 `firmware/` 作为最小可复现环境，`src/` 保留源码与分析材料
- `firmware/Dockerfile` 在构建期间会从 GitHub 拉取 `pwndbg`，离线环境下请自行准备缓存
