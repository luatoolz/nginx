# brotli config
```nginx
brotli on;
brotli_comp_level 6;
brotli_types text/xml image/svg+xml application/x-font-ttf image/vnd.microsoft.icon application/x-font-opentype application/json font/eot application/vnd.ms-fontobject application/javascript font/otf application/xml application/xhtml+xml text/javascript  application/x-javascript text/plain application/x-font-truetype application/xml+rss image/x-icon font/opentype text/css image/x-win-bitmap;
```

# test
```bash
$ curl -H 'Accept-Encoding: br' -I http://localhost
HTTP/1.1 200 OK
Server: nginx/1.24.0
Date: Thu, 24 Aug 2023 00:41:42 GMT
Content-Type: text/html
Last-Modified: Tue, 15 Aug 2023 19:24:52 GMT
Connection: keep-alive
ETag: W/"6434bbbe-267"
Content-Encoding: br
```
