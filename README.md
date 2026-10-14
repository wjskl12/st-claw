# 云酒馆部署（Claw Cloud Run · 长久免费）

> GitHub 账号注册超 180 天即可，每月白送 $5 免费额度，不绑卡、国内可直连、给 `*.claw.cloud` 域名，手机随时开。

## 原理

- 用 GitHub Actions 自动构建一个配好的 SillyTavern 镜像，推到 GHCR（GitHub 容器仓库）
- 在 Claw Cloud 拉这个镜像部署，挂持久卷存数据，自动给域名
- 全程不装 Docker、不碰命令行

## 第 1 步：把这几个文件传到 GitHub 仓库

1. 打开 https://github.com/new ，Repository name 填 `st-claw`，**Public**（Actions 免费额度要求公开仓），Create
2. 在新仓库点 **Add file > Create new file** / 或 **uploading an existing file**，把这 3 个文件传上去，保持目录结构：
   - `Dockerfile`
   - `config.yaml`
   - `.github/workflows/docker.yml`（注意要先建 `.github/workflows/` 目录，GitHub 网页上传时直接用这个路径名创建文件即可）
3. 传完进仓库的 **Actions** 标签页，能看到一个 "Build and Push SillyTavern Image" 的 workflow 自动跑起来了（黄圈→绿勾）
4. 等它跑完（约 2~4 分钟，在拉官方镜像+构建），绿勾 = 镜像构建好了
5. 打开 https://github.com/你的用户名?tab=packages ，能看到 `sillytavern` 镜像（workflow 会自动设为 public，拉取不用认证）

镜像地址：`ghcr.io/你的用户名/sillytavern:latest`

## 第 2 步：注册 Claw Cloud（拿 $5 免费额度）

1. 打开 https://console.run.claw.cloud/signin ，用 **GitHub 登录**（就是你那个超 180 天的账号）
2. 首次登录选区域：国内选 **Singapore**（新加坡）或 **Japan**（日本），离得近、快
3. 登录后点右上角头像 → Plan，能看到 **$5** 免费额度已到账

## 第 3 步：在 Claw Cloud 部署酒馆

1. 进 App Launchpad（应用启动台），点 **Create App** / 创建应用
2. 填：
   - **Image**：`ghcr.io/你的用户名/sillytavern:latest`
   - **App name**：随便，如 `st`
   - **CPU / Memory**：CPU 0.5 核、内存 1 GB（酒馆够用，约 $3/月，在 $5 免费额度内）
   - **Exposed Port**：`8000`（HTTP），勾上暴露/开启外网访问
   - **Persistent Storage**（持久卷）：挂一个卷，路径 `/home/node/app/data`，大小 1 GB（存角色卡、聊天、账号）
3. 点 **Deploy** / 部署
4. 部署完成后，Claw Cloud 会自动给一个 `https://xxx.claw.cloud` 域名，点进去

## 第 4 步：首次访问，建账号

1. 打开那个 `*.claw.cloud` 网址
2. 多用户模式下要登录，第一次注册一个账号（用户名+密码自己定）
3. 账号存在持久卷里，重启不丢
4. 进去后照常接 API（OpenAI/Claude/Gemini/中转站），配角色卡

## 第 5 步：手机用

- 手机浏览器直接开 `*.claw.cloud` 网址，登录即可
- 加到主屏幕当 App：Safari 分享 > 添加到主屏幕；Chrome 菜单 > 添加到主屏幕
- 电脑关机、出门在外，随时开链接就能聊

## 关于费用

- $5/月免费额度：0.5 核 + 1G 内存 + 1G 卷 大约 $3~4/月，够用且不超
- Claw Cloud 长久免费（每月循环赠送），不像 HF 会休眠，这个一直在线
- 超了才扣费，不绑卡则停机，不会倒扣钱

## 数据安全

- 角色卡、聊天、账号全在 `/home/node/app/data` 持久卷里，重启不丢
- 想备份：Claw Cloud 控制台可导出卷，或在酒馆里用自带备份功能下载
- 镜像里只有官方 ST + config，没有任何密钥/后门
