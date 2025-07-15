# lua+nginx docker image
```bash
docker pull luatoolz/nginx
```

# docker.compose.yml
```yml
services:
  nginx:
    image: luatoolz/nginx
    build: .
    restart: always
    read_only: true
    hostname: nginx
    ports:
      - 80:80
      - 443:443
    volumes:
      - /etc/keys
      - /var/www
    tmpfs:
      - /tmp:size=128M,uid=65534,gid=65533,mode=1777
      - /run:size=128M,uid=65534,gid=65533,mode=1777
```

# supports
* single nginx/lua app with precompiled
  - alpine (62mb)
  - libmongodb + libbson
  - libmaxmind
  - libidn2
  - jit/luarocks with support of:
  - openssl, resolver, acme, psl, net, utf8
  - read-only ok
  - autossl
