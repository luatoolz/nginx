# gzip config
```nginx
gzip on;
gzip_vary on;
gzip_proxied any;
gzip_comp_level 6;
gzip_types text/plain text/css text/xml application/json application/javascript application/xml+rss application/atom+xml image/svg+xml;
```

# test
```bash
$ curl -IL http://localhost -H "Accept-Encoding: gzip"
HTTP/1.1 200 OK
Server: nginx/1.24.0
Date: Thu, 24 Aug 2023 00:55:00 GMT
Content-Type: text/html
Last-Modified: Tue, 15 Aug 2023 19:24:52 GMT
Connection: keep-alive
Vary: Accept-Encoding
ETag: W/"6434bbbe-267"
Content-Encoding: gzip
```


# example 2
```nginx
http {
    gzip on;
    gzip_disable "msie6";  # Disable gzip for older browsers with known issues
    gzip_vary on;          # Enable varying gzip responses based on request headers
    gzip_proxied any;      # Compress responses even when the request is proxied
    gzip_comp_level 6;     # Set compression level (1-9, higher is more compressed but CPU-intensive)
    gzip_buffers 16 8k;    # Set number and size of buffers used for compression
    gzip_http_version 1.1; # Enable gzip for HTTP/1.1 and later
    gzip_min_length 256;   # Only compress files larger than this size (in bytes)

    # Specify the MIME types to compress
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
}
```

# decomp
[Static Decompression](https://docs.nginx.com/nginx/admin-guide/web-server/compression/)
