## 标题
SU CTF SQLi (PG17 + JS sign)

### 作者
待补充

### 方向
WEB

### 知识点

> 题目涉及的知识点

- PostgreSQL 错误回显注入（error-based SQLi）
- SQL/JSON 函数利用
- 客户端签名逆向（WASM）
- 简单 WAF 绕过

### 难度

> 分为：初级、中级、高级

待补充

### 内容

> 对题目进行一个简单的描述

题目为 Web 查询服务，接口要求携带前端签名。选手需要逆向签名逻辑并构造注入载荷，从数据库中获取 flag。

### 提示

> 为选手提供的提示，尤其是难题，需要准备 1-2 个提示

- 提示 1：先关注 `/api/sign` 与 `/api/query` 的签名关系。
- 提示 2：关注 PostgreSQL 在 SQL/JSON 函数场景下的错误信息差异。

### FLAG

> 每个步骤一个 flag，动态 flag 留白即可，系统根据 pushflag 脚本自动判断即可

分步模式

- 当前题目为静态 flag，来源于 `web_deploy/db/init.sql`（已同步到 `env/web_deploy/db/init.sql`）。
- 静态值（当前代码库）：`SUCTF{P9s9L_!Nject!On_IS_3@$Y_RiGht}`
- 当前为静态 flag，需人工确认是否改为动态注入。
- 已补充模板化脚本：`script/pushflag.sh` 与 `env/web_deploy/bin/pushflag.sh`。

随机模式（附件题防作弊专用）

- 待补充

### 是否可共享

待补充

### 备注

- 交付结构已按模板补全；为保留原题可运行性，原 `web_deploy/` 未删除，并复制到 `env/web_deploy/`。
- `env/web_deploy` 已改为单容器部署：同一容器内同时运行 PostgreSQL 17 与 Web 服务。
- `env/web_deploy/docker-compose.yml` 当前单服务镜像名为 `su_sqli:latest`，对外端口保持 `8080`。
- 已新增/使用 `env/web_deploy/bin/start.sh`，并由 `env/web_deploy/Dockerfile` 使用该脚本启动双进程。
- `env/web_deploy/bin/pushflag.sh` 已适配单容器，可在容器内更新 `/flag` 与数据库 `secrets.flag`。
- `script/pushflag.sh` 仍为模板基础版本（与交付容器脚本存在能力差异）。
- 当前为静态 flag，需人工确认是否改为动态注入。

## 本地复现

在 `env/web_deploy/` 目录执行 `docker compose up --build -d`。

## 归档瘦身说明

- 已移除 `env/su_sqli.tar` 和 `attachments/application.zip`
- 运行环境保留在 `env/web_deploy/`，前端附件保留在 `application/`
- 如需恢复附件压缩包，可在 `application/` 目录执行 `zip -rq ../attachments/application.zip .`

