## 标题
MirrorBus-9

### 作者
SUCTF-Design

### 方向
Misc

### 知识点
- 黑盒系统辨识
- 半双工批处理协议设计
- 延迟观测建模与确定性噪声剥离
- 状态控制与证明

### 难度
中高（可通过参数降难）

### 内容
选手通过 `nc` 连接半双工工业链路仿真器。  
命令先 `ENQ` 入队，`COMMIT` 执行，`POLL` 拉取延迟混合观测。  
需要完成黑盒建模并把隐藏状态控制到可 `ARM` 条件，再通过 `PROVE` 提交证明拿到 flag。

### 提示
- no-echo 是协议语义，不是服务挂了：优先观察 `STATUS/COMMIT/POLL`。
- 先做对照实验与重放，确认哪些是延迟、哪些是确定性噪声。
- 建议先固定单指令基线（如 `ENQ NOP` / `ENQ ROT 0`），再逐步叠加控制量。
- 终段证明建议关注 16-bit 工业校验关键词（CCITT），第三参数是标准 CRC16-CCITT。

### 建议赛时降难参数（不改机制）
如果当前解出率过低，可在部署时设置：
- `MB9_STATE_AMP=2`
- `MB9_OBS_AMP=6`
- `MB9_DELAY_MIN=0`
- `MB9_DELAY_SPAN=1`
- `MB9_ARM_TTL=192`
- `MB9_PROVE_ATTEMPTS=7`

以上仅降低噪声和时间压力，不改变 `ENQ/COMMIT/POLL + ARM/PROVE` 核心机制。

### FLAG
静态模式：服务仅从文件读取 flag（已加固，不读 `FLAG` 环境变量）。  
路径顺序：`/home/ctf/flag`，其次 `/flag`。

### 是否可共享
否（公共靶机建议开启 `MB9_SESSION_SEED_MODE=per_connection`，每条连接派生独立 session seed）

### 备注
- 主 seed 由 `MB9_SEED` 控制，可叠加 `TEAM_TOKEN` 派生。
- 公共靶机模式下，同一连接内 `RESET` 仍然严格重放；新连接会重新派生 session seed。
- 参考解、重放检查和多 seed 验证脚本均在 `sourcecode/mb9/author_tools/`。



