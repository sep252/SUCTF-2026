## 导出方法

使用 `docker save` 命令导出镜像：

```bash
docker save -o image_name.tar tagname:latest
```

注意：导出的文件名建议与镜像名对应。

当前状态：
- `env/web_deploy/` 已提供可构建部署文件。
- 该题当前为单服务单镜像部署（`su_uri:latest`）。
- `env/env.tar` 交付建议仅包含该镜像：

```bash
docker save -o env.tar su_uri:latest
```
