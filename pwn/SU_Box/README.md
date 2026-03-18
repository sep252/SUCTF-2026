## 标题

SU_Box

### 作者

flyyy

### 方向

pwn

### 知识点

>题目涉及的知识点

- v8 n-day的Patch gap问题

### 难度

>分为：初级、中级、高级

中级

### 内容

>对题目进行一个简单的描述

java ？but not java

### 提示

>为选手提供的提示，尤其是难题，需要准备1-2个提示

- jar包里有内置的v8
- v8的 nday bypass？

### FLAG

>每个步骤一个flag，动态flag留白即可，系统根据pushflag脚本自动判断即可

分步模式

- SUCTF{y0u_kn@w_v8_p@tch_gap_we1!}


### 是否可共享

否

###  备注

>选手最终得到的是flag{}之间的字符串，提交需加上flag{}

## 本地复现

在 `env/pwn_deploy/` 目录执行 `docker compose up --build -d`。

## 归档瘦身说明

- 已移除 `env/su_box.tar` 和 `attachments/pwn_deploy.zip`，两者分别是镜像导出包和重复附件压缩包
- 仓库保留 `env/pwn_deploy/` 作为最小可复现集，不影响本地起题
- 如需恢复附件压缩包，可在 `env/pwn_deploy/` 下执行 `zip -rq ../../attachments/pwn_deploy.zip .`
