## 导出方法

使用 `docker save` 命令导出镜像：

```bash
docker save -o image_name.tar tagname:latest
```

注意：导出的文件名建议与镜像名对应。

当前状态：
- `env/web_deploy/` 已改为单容器部署（镜像：`su_sqli:latest`）。
- 导出建议：

```bash
docker save -o su_sqli.tar su_sqli:latest
```

