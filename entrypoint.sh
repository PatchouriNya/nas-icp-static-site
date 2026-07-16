#!/bin/sh
# 从挂载目录复制文件并修正权限，解决 NAS 挂载 403 问题
cp -f /data/index.html /usr/share/nginx/html/index.html 2>/dev/null
chmod -R 755 /usr/share/nginx/html/
exec nginx -g 'daemon off;'
