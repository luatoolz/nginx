# syntax=docker/dockerfile:1
ARG SOURCE_DATE_EPOCH=${SOURCE_DATE_EPOCH:-0}
ARG LUA_VERSION=${LUA_VERSION:-5.1}

FROM alpine:latest AS sys
ARG SOURCE_DATE_EPOCH
ARG LUA_VERSION

ARG itools="ca-certificates curl iputils-ping bash bind-tools mc procps sudo net-tools"
ARG idev="build-base gcc git cmake make pkgconf"
ARG ilib="luarocks luajit lua${LUA_VERSION} openssl     zlib     libbson-static libmaxminddb libmaxminddb-libs mongo-c-driver-static"
ARG iheaders="lua${LUA_VERSION}-dev lua-dev openssl-dev zlib-dev libidn2-dev    libmaxminddb-dev"
ARG iserv="nginx nginx-mod-http-lua nginx-mod-http-echo"

RUN apk upgrade --no-cache && apk add --no-cache ${itools} ${idev} ${ilib} ${iheaders} ${iserv}

RUN rm -rf /var/lib/nginx/tmp /var/www/localhost && \
    mkdir /etc/keys /etc/nginx/env.d && \
    ln -s /var/tmp /var/lib/nginx/tmp && \
    touch /var/log/nginx/error.log && \
    chown nginx /etc/keys /etc/nginx/env.d /var/log/nginx/error.log /var/www && \
    truncate -s 0 /var/lib/nginx/html/index.html

RUN ln -s /usr/bin/luarocks-${LUA_VERSION} /usr/bin/luarocks
RUN luarocks config --scope system lua_dir /usr
RUN luarocks install qluarocks

FROM sys AS lib
ARG SOURCE_DATE_EPOCH
ARG LUA_VERSION
ARG irocks="busted compat53 paths rapidjson lua-cjson say luafilesystem luassert date \
  idn2 lua-maxminddb lua-mongo luaossl luaresolver lua-resty-string lua-resty-acme luasocket \
  luautf8 net-url public_suffix_list"

RUN qluarocks install ${irocks}
RUN apk del ${idev}
RUN rm -rf /var/cache/*

FROM scratch
ARG SOURCE_DATE_EPOCH
ARG LUA_VERSION
COPY --from=lib / /
ADD . /

SHELL ["/bin/bash", "-c"]
HEALTHCHECK --start-period=30s --start-interval=5s --retries=1 --interval=10s --timeout=1s  CMD curl || exit 1
CMD ["/usr/sbin/nginx", "-e", "stderr"]

RUN openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
  -subj '/CN=sni-support-required-for-valid-ssl' \
  -keyout /etc/ssl/default.key \
  -out /etc/ssl/default.pem
