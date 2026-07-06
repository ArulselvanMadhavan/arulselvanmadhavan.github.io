#!/bin/sh
set -eu

port="${PORT:-8080}"

cd /workspace/_site
exec python3 -c "
import http.server
import os
import socketserver

port = int(os.environ.get('PORT', '8080'))
socketserver.TCPServer(('0.0.0.0', port), http.server.SimpleHTTPRequestHandler).serve_forever()
"
