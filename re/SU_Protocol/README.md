## 标题
SU_Protocol

### 作者
YuHuanTin

### 方向
reverse

### 知识点

>题目涉及的知识点

- 脱壳
- tea
- 算法
- 结构体分析

### 难度

>分为：初级、中级、高级

中级

### 内容

>对题目进行一个简单的描述

一个简单算法逆向

### 提示

>为选手提供的提示，尤其是难题，需要准备1-2个提示

- 协议长度字段后一字节为0x80且协议最后一字节为 0x16，you_input为全小写


### FLAG

>每个步骤一个flag，动态flag留白即可，系统根据pushflag脚本自动判断即可

分步模式

- SUCTF{ad1b51464c1b679fe731c7d718af241f}

随机模式（附件题防作弊专用）

>这里对应防作弊模式里面，不同附件对应不同flag，所以这里需要填上attachments文件夹里附件的名称，例如easyreverse1.zip

- taskdemo1.zip  
  - flag{cfcd208495d565ef66e7dff9f98764da}

- taskdemo2.zip
  - flag{c4ca4238a0b923820dcc509a6f75849b}

- taskdemo3.zip
  - flag{c81e728d9d4c2f636f067f89cc14862c}
  
- taskdemo4.zip
  - flag{eccbc87e4b5ce2fe28308fd9f2a7baf3}
  
- taskdemo5.zip
  - flag{a87ff679a2f3e71d9181a67b7542122c}
  
- taskdemo6.zip
  - flag{e4da3b7fbbce2345d7772b0674a318d5}
  
- taskdemo7.zip
  - flag{1679091c5a880faf6fb5e6087eb1b2dc}
  
- taskdemo8.zip
  - flag{8f14e45fceea167a5a36dedd4bea2543}
  
- taskdemo9.zip
  - flag{c9f0f895fb98ab9159f51fd0297e236d}
  
- taskdemo10.zip
  - flag{45c48cce2e2d7fbdea1afc51c7c6ad26}

### 是否可共享

否

###  备注

>选手最终得到的是SUCTF{}之间的字符串，提交需加上SUCTF{}

## 归档瘦身说明

- 已移除 `env/env.tar`，它是模板环境导出的整镜像包
- 仓库保留 `env/pwn_deploy/` 与 `env/web_deploy/` 两套最小可复现目录，后续维护直接基于保留目录进行即可

