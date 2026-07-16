# NAS ICP 备案展示页

极简博客风格纯静态单页网站，专为工信部 ICP 备案核验设计，部署在个人 NAS 设备。

- 单文件 `index.html`，所有样式内嵌，零外部依赖
- 完全响应式，电脑/手机均正常显示
- 隐藏编辑入口，页面中直接修改备案号，所有设备立即生效
- 支持 amd64/arm64 双平台镜像

## 一键部署

### Docker Compose 部署（推荐）

1. 在 NAS 上创建目录并下载 `index.html`：

```bash
mkdir -p /volume1/docker/icp-site && cd /volume1/docker/icp-site

curl -O https://raw.githubusercontent.com/PatchouriNya/nas-icp-static-site/main/index.html
```

2. 创建 `docker-compose.yml`：

```yaml
services:
  icp-site:
    image: ghcr.io/patchourinya/nas-icp-static-site:latest
    container_name: icp-site
    ports:
      - "8080:80"
    volumes:
      - /volume1/docker/icp-site:/data
    restart: unless-stopped
```

3. 修改备案号，编辑 `index.html`，将底部的 `京ICP备XXXXXXXX号-1` 替换为你自己的备案号。

4. 启动容器：

```bash
docker compose up -d
```

5. 访问 `http://NAS的IP:8080` 即可看到页面。

> 端口修改：将 `"8080:80"` 左侧的 `8080` 改为 NAS 空闲端口。

## 修改备案号

### 方式一：页面隐藏入口（推荐）

快速连击页面顶部站点名称 **5 次** → 弹出备案号编辑面板 → 输入备案号 → 点击保存。

修改直接写入服务器文件，**所有设备立即生效，无需重启**。

### 方式二：编辑 NAS 本地文件

直接在 NAS 文件管理器中编辑 `/volume1/docker/icp-site/index.html`，替换备案号后保存，**需重启容器生效**：

```bash
docker compose restart
```

## 常用命令

```bash
# 启动
docker compose up -d

# 停止
docker compose down

# 重启
docker compose restart

# 查看状态
docker compose ps

# 查看日志
docker compose logs

# 更新镜像
docker compose pull && docker compose up -d
```

## 自定义站点信息

编辑 `index.html` 即可修改：

- 站点名称：`<h1>个人博客</h1>`
- 一句话介绍：`<p class="subtitle">记录生活，分享思考</p>`
- 建设中文案：`<h2>网站建设中</h2>`
- 副标题：`<p>内容正在筹备，敬请期待</p>`

## GitHub Actions 自动构建

推送到 `main` 分支后，GitHub Actions 自动构建 Docker 镜像并推送到 GHCR。

- 镜像地址：`ghcr.io/patchourinya/nas-icp-static-site:latest`
- 支持平台：`linux/amd64`、`linux/arm64`

## 资源占用

| 指标 | 数值 |
|------|------|
| 镜像体积 | ~25MB |
| 运行内存 | ~5MB |
| 外部请求 | 0 |
| JS 依赖 | 0 |
