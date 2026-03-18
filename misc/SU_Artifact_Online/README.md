## 标题
SU_Artifact_Online



### 作者
2hi5hu



### 方向
Misc



### 知识点

>题目涉及的知识点

- 单表替换密文映射推断（词频分析）
- 魔方原理
- 路径推理
- 命令构造



### 难度

高级



### 内容

>对题目进行一个简单的描述

By chance, you discovered a mysterious machine along with a strange file inscribed with cryptic runes. Can you decipher the runes and uncover the truth hidden within the machine?

It is recommended to connect to the target machine using `stty raw -echo; ncat --ssl xxxxxxxxx xxxx; stty sane`  for the best experience.





### 提示

>为选手提供的提示，尤其是难题，需要准备1-2个提示

- Each rune represents a character.
- The flag is not located in the current directory



### FLAG

- SUCTF{Th1s_i5_@_Cub3_bu7_n0t_5ome7hing_u_pl4y}



### 是否可共享

否



###  备注

>无

## 本地复现

在 `env/` 目录执行 `docker compose up --build -d`，服务默认监听 `9999` 端口。

## 归档瘦身说明

- 已移除 `env/artifact.tar`，它是 `docker save` 导出的整镜像，不适合直接进入 GitHub
- 仓库保留了 `sourcecode/server/` 全量构建上下文，并新增 `env/docker-compose.yml` 直接从源码构建
- 这不会影响题目本地复现；如需重建镜像，直接使用 `docker compose build` 或 `docker build ./sourcecode/server`

