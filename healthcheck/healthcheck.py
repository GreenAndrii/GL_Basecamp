# -*- coding: utf-8 -*-
from http.server import HTTPServer, BaseHTTPRequestHandler
from socket import gethostname, gethostbyname
import os


class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        print(self.path)
        if self.path == '/healthz':
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b'200 OK\n')
        elif self.path == '/readinez':
            self.send_response(200)
            self.end_headers()
            self.wfile.write((gethostbyname(gethostname()) + '\n').encode())
        elif self.path == '/':
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b'Version:v7.0.0\n')
        else:
            self.send_response(404)
            self.end_headers()
            self.wfile.write(b'Page not found\n')

def run():
  server_port = int(os.getenv('SERVER_PORT'))
  print("HTTP server started at port: " + str(server_port))
  httpd = HTTPServer(('0.0.0.0', server_port), SimpleHTTPRequestHandler)
  httpd.serve_forever()


if __name__ == '__main__':
  run()
