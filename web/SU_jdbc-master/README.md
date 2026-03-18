## 标题
SU_jdbc-master

### 作者
狗and猫

### 方向
web

### 知识点

>题目涉及的知识点

- unicode 字符绕过  + Spring 底层解析特性
- json 属性覆盖
- kingbase8 全新参数绕过
- 利用驱动特性实现不出网利用

### 难度

>分为：初级、中级、高级

高级

### 内容

>对题目进行一个简单的描述

由实战改编 证明你是jdbc大师的时候到了(PS：请在本地能够稳定获得flag的前提下再尝试线上环境)

题目地址(环境均相同)为1.95.113.59:10018/10019/10020 两分钟重启一次。若你确信你本地能够稳定获得flag，但是线上打不通，可以向管理申请单独开一个环境

Adapted from real-world practice, it's time to prove you're a JDBC master!(P.S.: Please only try the online environment if you can reliably obtain the flag locally.)

The challenge URL (same for all environments) is 1.95.113.59:10018/10019/10020. It restarts every two minutes. If you are confident you can reliably obtain the flag locally but cannot complete the online challenge, you can request a separate environment from the administrator.

### 提示

>为选手提供的提示，尤其是难题，需要准备1-2个提示

- 
- 

### FLAG

>每个步骤一个flag，动态flag留白即可，系统根据pushflag脚本自动判断即可

suctf{u5Ing_JdbC_70_rce_iS_vEry_s1mpl3!_!!}

### 是否可共享

否

###  备注

>选手最终得到的是flag{}之间的字符串，提交需加上flag{}

## 本地复现

在 `env/web_deploy/` 目录执行 `docker compose up --build -d`。

## 归档瘦身说明

- 已移除 `env/jdbc-master.tar` 和 `attachments/web_deploy.zip`，它们分别是镜像导出包和重复部署压缩包
- 仓库保留 `env/web_deploy/` 作为最小可复现集，不影响本地起题
- 如需恢复附件压缩包，可在 `env/web_deploy/` 下执行 `zip -rq ../../attachments/web_deploy.zip .`

