#!/usr/bin/env python3
"""Lightweight API server for updating ICP filing number."""
import os, re, json
from http.server import HTTPServer, BaseHTTPRequestHandler

DATA_DIR = '/data'
HTML_DIR = '/usr/share/nginx/html'

class Handler(BaseHTTPRequestHandler):
    def do_POST(self):
        if self.path != '/api/icp':
            self.send_error(404)
            return
        try:
            length = int(self.headers.get('Content-Length', 0))
            data = json.loads(self.rfile.read(length))
            icp = data.get('icp', '').strip()
            if not icp:
                self.send_error(400)
                return
            for d in [DATA_DIR, HTML_DIR]:
                path = os.path.join(d, 'index.html')
                if os.path.isfile(path):
                    with open(path, 'r', encoding='utf-8') as f:
                        content = f.read()
                    content = re.sub(
                        r'(<a id="icp-link"[^>]*>)(.*?)(</a>)',
                        r'\g<1>' + re.escape(icp) + r'\g<3>',
                        content
                    )
                    with open(path, 'w', encoding='utf-8') as f:
                        f.write(content)
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            self.wfile.write(b'{"ok":true}')
        except Exception:
            self.send_error(500)

    def log_message(self, *args):
        pass

if __name__ == '__main__':
    HTTPServer(('127.0.0.1', 3000), Handler).serve_forever()
