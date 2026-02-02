FROM alpine:latest

# https://mirrors.alpinelinux.org/
RUN sed -i 's@dl-cdn.alpinelinux.org@ftp.halifax.rwth-aachen.de@g' /etc/apk/repositories

RUN apk update
RUN apk upgrade

# required tinc vpn
RUN apk add --no-cache \
  gcc make linux-headers musl-dev zlib-dev zlib-static \
  python3-dev curl meson ninja lzo-dev lz4-dev lz4-static \
  openssl-dev openssl-libs-static readline-dev readline-static \
  ncurses-static git bash xz

ENV XZ_OPT=-e9
COPY build-static-tinc.sh build-static-tinc.sh
RUN chmod +x ./build-static-tinc.sh
RUN bash ./build-static-tinc.sh
