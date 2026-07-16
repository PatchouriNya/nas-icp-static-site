FROM nginx:alpine

LABEL org.opencontainers.image.source=https://github.com/PatchouriNya/nas-icp-static-site
LABEL org.opencontainers.image.description="Minimal static ICP filing page for NAS deployment"
LABEL org.opencontainers.image.licenses=MIT

# 让 nginx worker 以 root 运行，避免 NAS 挂载目录权限问题导致 403
RUN sed -i 's/user  nginx;/user  root;/' /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html
