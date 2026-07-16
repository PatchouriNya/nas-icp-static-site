#!/bin/sh
# Copy files from mounted data dir
cp -f /data/index.html /usr/share/nginx/html/index.html 2>/dev/null
chmod -R 755 /usr/share/nginx/html/

# Start API server in background
python3 /app/api.py &

# Start nginx in foreground
exec nginx -g 'daemon off;'
