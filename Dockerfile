FROM nginx:alpine

LABEL org.opencontainers.image.source=https://github.com/PatchouriNya/nas-icp-static-site
LABEL org.opencontainers.image.description="Minimal static ICP filing page for NAS deployment"
LABEL org.opencontainers.image.licenses=MIT

COPY index.html /usr/share/nginx/html/index.html
