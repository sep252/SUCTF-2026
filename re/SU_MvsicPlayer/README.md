题目标题：SU_MvsicPlayer

作者：Xherlock

方向：Reverse

知识点：Electron逆向、VM、

难度：中等

内容：百度网盘：https://pan.baidu.com/s/1p3toz3wVHYl53bP9zKaonw?pwd=duwr
Google Drive：https://drive.google.com/file/d/1hVBx0pFLw-uqAnUWSCLgCbFCLQM7GrTd/view?usp=sharing

## 本地复现

- 在 `attachments/` 目录运行 `./restore_attachment.sh`
- 解出 `SU_MusicPlayer.zip` 后即可得到原始赛题附件
- 分析流程见 `writeup/`，辅助材料见 `sourcecode/` 与 `exp/`

## 归档瘦身说明

- 原始 `attachments/SU_MusicPlayer.zip` 超过 GitHub 单文件限制，现改为 `SU_MusicPlayer.zip.part-*` 分片保存
- `restore_attachment.sh` 会按顺序拼回原始 zip，并根据 `SU_MusicPlayer.zip.sha256` 校验
- 该改动不影响题目复现，只是把大附件改成了 GitHub 可上传的保存方式
