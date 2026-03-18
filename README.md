# SUCTF-2026 Archive

本仓库保留 SUCTF 2026 题目的 GitHub 友好最小可复现集，优先级为：

- 保证题目可复现
- 尽量压缩仓库体积
- 保持长期归档可维护

## 归档约定

- `attachments/`：选手附件或公开附件
- `env/`：可直接启动的环境，或最小可复现构建上下文
- `sourcecode/`：题目源码或瘦身后的源码快照
- `writeup/`：官方题解
- `exp/`：利用脚本、求解脚本或复现脚本
- 运行时生成目录如 `logs/`、`tmp/`、`uploads/`、`__pycache__/`、`.pytest_cache/` 不入库
- 纯 `docker save` 导出的镜像包、重复压缩包、构建缓存、系统垃圾文件不入库

## 复现规则

- `docker-compose`：进入表中给出的目录后执行 `docker compose up -d --build`
- `dockerfile`：以表中给出的目录为 build context 手动执行 `docker build` 和 `docker run`
- `archive`：无独立服务环境，直接使用附件和 writeup 复现解题流程
- `metadata-only`：当前只保留题目信息，未保存完整运行环境

## 题目索引

| 分类 | 题目 | 类型 | 复现入口 |
| :-- | :-- | :-- | :-- |
| AI | SU_babyAI | archive | `AI/SU_babyAI/解题赛模板/` |
| AI | SU_easyLLM | archive | `AI/SU_easyLLM/解题赛模板/` |
| crypto | SU_AES | docker-compose | `crypto/SU_AES/` |
| crypto | SU_Isogeny | docker-compose | `crypto/SU_Isogeny/解题赛模板/env/deploy/docker/` |
| crypto | SU_Lattice | docker-compose | `crypto/SU_Lattice/解题赛模板/env/deploy/docker/` |
| crypto | SU_Prng | docker-compose | `crypto/SU_Prng/` |
| crypto | SU_Restaurant | docker-compose | `crypto/SU_Restaurant/解题赛模板/env/deploy/docker/` |
| crypto | SU_RSA | archive | `crypto/SU_RSA/attachments/` + `crypto/SU_RSA/writeup/` |
| misc | SU_Artifact_Online | docker-compose | `misc/SU_Artifact_Online/env/` |
| misc | SU_chaos | archive | `misc/SU_chaos/attachments/` |
| misc | SU_CyberTrack | archive | `misc/SU_CyberTrack/attachments/website.zip` |
| misc | SU_forensics | archive | `misc/SU_forensics/解题赛模板/` |
| misc | SU_LightNovel | archive | `misc/SU_LightNovel/attachments/` |
| misc | SU_MirrorBus-9 | docker-compose | `misc/SU_MirrorBus-9/env/pwn_deploy/` |
| pwn | SU_Box | docker-compose | `pwn/SU_Box/env/pwn_deploy/` |
| pwn | SU_Chronos_Ring | docker-compose | `pwn/SU_Chronos_Ring/env/pwn_deploy/` |
| pwn | SU_Chronos_Ring1 | docker-compose | `pwn/SU_Chronos_Ring1/env/pwn_deploy/` |
| pwn | SU_EzRouter | dockerfile | `pwn/SU_EzRouter/firmware/` |
| pwn | SU_evbuffer | dockerfile | `pwn/SU_evbuffer/env/` |
| pwn | SU_fullchian | metadata-only | `pwn/SU_fullchian/README.md` |
| pwn | SU_minivfs | dockerfile | `pwn/SU_minivfs/env/` |
| re | SU_Protocol | archive | `re/SU_Protocol/attachments/` + `re/SU_Protocol/env/` |
| re | SU_West | archive | `re/SU_West/attachments/SU_West.zip` |
| re | SU_easygal | archive | `re/SU_easygal/attachments/` + `re/SU_easygal/env/` |
| re | SU_flumel | archive | `re/SU_flumel/attachments/attachment.zip` + `re/SU_flumel/sourcecode/sourcecode.zip` |
| re | SU_Lock | archive | `re/SU_Lock/attachments/` |
| re | SU_MvsicPlayer | archive | `re/SU_MvsicPlayer/attachments/restore_attachment.sh` |
| re | SU_revird | archive | `re/SU_revird/attachments/SU_Revird.zip` |
| re | SU_老年固件 | archive | `re/SU_老年固件/attachment.zip` |
| web | SU_jdbc-master | docker-compose | `web/SU_jdbc-master/env/web_deploy/` |
| web | SU_sqli | docker-compose | `web/SU_sqli/env/web_deploy/` |
| web | SU_Thief | dockerfile | `web/SU_Thief/env/` |
| web | SU_uri | docker-compose | `web/SU_uri/env/web_deploy/` |
| web | SU_wms | docker-compose | `web/SU_wms/env/` |

## 大文件替代说明

| 题目 | 已移除或转换 | 保留内容 | 恢复方式 |
| :-- | :-- | :-- | :-- |
| misc/SU_Artifact_Online | `env/artifact.tar` | `sourcecode/server/` + `env/docker-compose.yml` | 直接 `docker compose up -d --build`，无需恢复镜像导出包 |
| pwn/SU_Box | `env/su_box.tar`、`attachments/pwn_deploy.zip` | `env/pwn_deploy/`、`sourcecode/sourcecode.zip` | 如需重新打附件，在 `env/pwn_deploy/` 下执行 `zip -rq ../../attachments/pwn_deploy.zip .` |
| pwn/SU_Chronos_Ring* | `env/*.tar`、附件 zip | `env/pwn_deploy/` | 如需恢复附件，在对应 `env/pwn_deploy/` 下重新 `zip -rq` |
| re/SU_easygal | `env/env.tar` | `env/pwn_deploy/`、`env/web_deploy/`、`attachments/` | 当前保留目录已可继续归档维护，无需镜像导出包 |
| re/SU_flumel | 原始 `1.69G` `sourcecode/sourcecode.zip` | 去掉 `.dart_tool/.gradle/build` 和大体积产物后的瘦身源码包 | 重新编译时按 Flutter/Android 工具链恢复依赖并本地构建 |
| re/SU_MvsicPlayer | `attachments/SU_MusicPlayer.zip` | GitHub 友好的 `SU_MusicPlayer.zip.part-*` 分片 | 运行 `re/SU_MvsicPlayer/attachments/restore_attachment.sh` |
| re/SU_Protocol | `env/env.tar` | `env/pwn_deploy/`、`env/web_deploy/`、`attachments/` | 当前保留目录已可继续归档维护，无需镜像导出包 |
| web/SU_jdbc-master | `env/jdbc-master.tar`、`attachments/web_deploy.zip` | `env/web_deploy/` | 如需恢复附件，在 `env/web_deploy/` 下重新 `zip -rq ../../attachments/web_deploy.zip .` |
| web/SU_sqli | `env/su_sqli.tar`、`attachments/application.zip` | `env/web_deploy/`、`application/` | 如需恢复附件，在 `application/` 下重新打包 |
| web/SU_uri | `env/su_uri.tar` | `env/web_deploy/` | 直接从保留的构建目录启动 |
| web/SU_wms | `attachments/jeewms_580e924.zip`、单文件 `env/jeewms.war` | GitHub 友好的 `env/jeewms/` 展开目录 | 运行 `web/SU_wms/env/repack_jeewms.sh` 可重新生成 `jeewms.war` |

## 外部依赖与注意事项

- 大部分服务题只依赖 Docker / Docker Compose；构建镜像时可能需要联网拉取基础镜像和系统包
- `pwn/SU_Chronos_Ring` 与 `pwn/SU_Chronos_Ring1` 需要宿主机提供 `/dev/kvm`
- `pwn/SU_EzRouter` 的 Dockerfile 在构建时会从 GitHub 拉取 `pwndbg`
- `re/SU_flumel` 若要重新编译 APK，需要本地 Flutter / Android toolchain
- `re/SU_Lock` 建议在开启测试模式的 Windows 10/11 虚拟机中复现
