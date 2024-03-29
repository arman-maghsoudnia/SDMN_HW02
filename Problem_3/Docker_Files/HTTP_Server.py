from http.server import BaseHTTPRequestHandler, HTTPServer

class handler(BaseHTTPRequestHandler):
    store_path = 'api/v1/status/status.json'

    def do_GET(self):
        try:
            if self.path == '/api/v1/status' or self.path == '/api/v1/status/status.json':
                with open(self.store_path) as fh:
                    self.send_response(200)
                    self.send_header('Content-type', 'text/json')
                    self.end_headers()
                    self.wfile.write(fh.read().encode())
            else:
                self.send_error(405,'This is NOT Allowed in our Web Server. You can only GET this path: /api/v1/status/status.json')
        except IOError:
            self.send_error(404,'File Not Found: %s' % self.path)

    def do_POST(self):
        if self.path == '/api/v1/status' or self.path == '/api/v1/status/status.json':
            length = self.headers['content-length']
            data = self.rfile.read(int(length))
            with open(self.store_path, 'w') as fh:
                fh.write(data.decode() + '\n')
            self.send_response(201)
            self.send_header('Content-type','text/html')
            self.end_headers()
            self.wfile.write(bytes(data.decode() + '\n', "utf8"))
        else:
            self.send_error(405,'This is NOT Allowed in our Web Server. You can only POST to this path: /api/v1/status/status.json')



with HTTPServer(('', 8000), handler) as server:
    server.serve_forever()