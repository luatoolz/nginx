# lua+nginx docker image
```bash
docker pull luatoolz/nginx
```

Why? I just have tons of similar but very different apps, builds, images, etc.
So i'd like to try a 'crumb'-way nginxing. At least i didn't find any good way out there.

Hope to get simple, self-bootstrapped and reusable with minimal time overhead.

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
      - 8088:80
      - 4438:443
    volumes:
      - /etc/keys
      - /var/tmp
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

# status
There is still more refactoring than progress but usable.

# todo
* auto ssl from [letsencrypt.com](https://letsencrypt.com)
* better code, more working samples
