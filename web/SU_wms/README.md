## 标题
SU_wms

### 作者
狗and猫

### 方向
web

### 知识点

>题目涉及的知识点

- 鉴权绕过
- mysql jdbc 打 fastjson

### 难度

>分为：初级、中级、高级

中级

### 内容

>对题目进行一个简单的描述

简单的小0day，试试前台RCE吧(PS：请在本地能够稳定获得flag的前提下再尝试线上环境)

题目地址(环境均相同)为101.245.81.83:10018/10019 五分钟重启一次

A simple zero-day trial, try front-end RCE(P.S.: Please only try the online environment if you can reliably obtain the flag locally.)

The problem URL (same environment) is 101.245.81.83:10018/10019. The game restarts every five minutes.

### 提示

>为选手提供的提示，尤其是难题，需要准备1-2个提示

- 
- 

### FLAG

>每个步骤一个flag，动态flag留白即可，系统根据pushflag脚本自动判断即可

suctf{v3ry_e45y_uN4utHOrIZEd_rC3!_!aAA}

### 是否可共享

否

###  备注

>选手最终得到的是flag{}之间的字符串，提交需加上flag{}

## 本地复现

在 `env/` 目录执行 `docker compose up --build -d`。

## 归档瘦身说明

- 已移除 `attachments/jeewms_580e924.zip`，因为它与保留的运行环境内容重复
- `env/jeewms.war` 超过 GitHub 单文件限制，现改为 `env/jeewms/` 展开目录，并已同步更新 `env/Dockerfile`
- 本地起题不需要恢复 `war`；如需重新生成，可运行 `env/repack_jeewms.sh`

