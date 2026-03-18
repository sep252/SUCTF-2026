## 标题
CloudHook Service (SU_uri)

### 作者
待补充

### 方向
WEB

### 知识点

> 题目涉及的知识点

- SSRF 防护绕过
- DNS Rebinding（校验时解析与请求时解析不一致）
- Docker Socket 暴露风险
- Docker Remote API 利用链
- IPv4-mapped IPv6 等价本地地址识别与拦截

### 难度

> 分为：初级、中级、高级

待补充

### 内容

> 对题目进行一个简单的描述

题目为 webhook 转发服务。服务端对目标 URL 做了基础校验后再发起请求，选手可利用 DNS Rebinding 绕过校验并访问容器内映射的 Docker API，最终获取 flag。

### 提示

> 为选手提供的提示，尤其是难题，需要准备 1-2 个提示

- 提示 1：URL 校验阶段与真实请求阶段对同一域名的解析结果可能不同。
- 提示 2：关注容器内是否存在可被间接访问的本地管理接口。

### FLAG

> 每个步骤一个 flag，动态 flag 留白即可，系统根据 pushflag 脚本自动判断即可

分步模式

- 当前题目为静态 flag，核心来源为 `setup/readflag.c` 编译出的 `/readflag` 输出。
- 当前代码库中的静态值：`SUCTF{SsRF_tO_rC3_by_d0CkEr_15_s0_FUn}`
- 当前为静态 flag，需人工确认是否改为动态注入。
- 已补充模板化脚本：`script/pushflag.sh` 与 `env/web_deploy/bin/pushflag.sh`（当前未真正接入漏洞链路中的最终 flag 生成流程）。

随机模式（附件题防作弊专用）

- 待补充

### 是否可共享

待补充

### 备注

- 交付结构已按模板补全；为保留原题可运行性，原 `web_deploy/` 未删除，并复制到 `env/web_deploy/`。
- `env/web_deploy` 已改为单服务单镜像（`cloudhook-service` / `su_uri:latest`），仍保持原题漏洞链路。
- 已修复非预期旁路：`[::ffff:127.0.0.1]` 等 IPv4-mapped IPv6 本地地址形式会被拦截。
- 预期解法仍为 DNS Rebinding 路线。
- 当前为静态 flag，需人工确认是否改为动态注入。

## 本地复现

在 `env/web_deploy/` 目录执行 `docker compose up --build -d`。

## 归档瘦身说明

- 已移除 `env/su_uri.tar`，它是重复的镜像导出包
- 仓库保留 `env/web_deploy/` 作为最小可复现集，不影响本地起题
