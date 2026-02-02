#! /bin/bash

set -e

WORKSPACE=/tmp/workspace
mkdir -p $WORKSPACE
mkdir -p /work/artifact

# tinc vpn
cd $WORKSPACE
git clone -b 1.1 https://github.com/gsliepen/tinc
cd tinc
CFLAGS="$CFLAGS -static" LDFLAGS="-static --static -no-pie -s" meson setup builddir -Dprefix=/usr/local/tincmm -Dbuildtype=minsize -Dlzo=enabled -Dlz4=enabled -Dtests=disabled -Ddefault_library=static --strip
cd builddir
sed -i 's@.so.3 @.a @g' ./build.ninja
sed -i 's@.so @.a @g' ./build.ninja
ninja
ninja install

cd /usr/local
tar vcJf ./tincmm.tar.xz tincmm

mv ./tincmm.tar.xz /work/artifact/
