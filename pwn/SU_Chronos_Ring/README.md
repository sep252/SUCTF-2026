## 标题
Chronos_Ring

### 作者
Yigod

### 方向
pwn

### 知识点

>题目涉及的知识点

权限配置不当，修改  /bin/sleep 为 

#!/bin/sh 

chmod +rwx /flag 

然后 cat /flag

### 难度

>分为：初级、中级、高级

初级

### 内容

>对题目进行一个简单的描述

a y no , cat flag plz

### 提示

>为选手提供的提示，尤其是难题，需要准备1-2个提示

### FLAG

>每个步骤一个flag，动态flag留白即可，系统根据pushflag脚本自动判断即可

SUCTF{VGhhc19BU19XSEFUX1Vfd0FudF9mbGFnX2ZsYWdfZmxhZyEhIQ==}

### 是否可共享

否

###  备注

>选手最终得到的是flag{}之间的字符串，提交需加上flag{}

## 本地复现

在 `env/pwn_deploy/` 目录执行 `docker compose up --build -d`。该题依赖宿主机 `/dev/kvm`。

## 归档瘦身说明

- 已移除 `env/chronos-ring.tar` 和 `attachments/attachments.zip`，它们分别是镜像导出包和与运行目录重复的附件包
- 仓库保留 `env/pwn_deploy/` 作为最小可复现集
- 如需恢复附件压缩包，可在 `env/pwn_deploy/` 下执行 `zip -rq ../../attachments/attachments.zip .`

