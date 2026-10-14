# 官方 SillyTavern 镜像 + 预置 HF/Claw Cloud 适配 config
# 用官方 entrypoint（会 npm run init 补全 config + exec node server.js --listen）
FROM ghcr.io/sillytavern/sillytavern:latest

USER root
COPY config.yaml /home/node/app/config/config.yaml
RUN chown -R node:node /home/node/app/config

USER node
