#!/bin/bash

# Nginx version
version=1.4.7
# Dependencies versions
deps=("pcre", 8.32)

DEPS_LIB=""
for ((i = 0; i < ${#deps[@]}; ++i)); do
    kv=${deps[$i]}    
    pkg=${kv%,*}
    ver=${kv##*,}
    echo "$pkg :: $ver"
    DEPS_LIB=$PWD/deps/$pkg/$ver/build-tree:$DEPS_LIB
done
echo "$DEPS_LIB"
export LD_LIBRARY_PATH=$DEPS_LIB:$LD_LIBRARY_PATH

#exit

BASE=$PWD
INSTALL_DIR=$BASE/$version/build-tree
DEPS_SRC_DIR=$BASE/deps
MODULE_DIR=$BASE/ext-modules

function download_pkg()
{
    ver=$1
    fname=nginx-$ver
    tarball=$fname.tar.gz
    wget http://nginx.org/download/$tarball
    tar -zxvf $tarball
    mv $fname $ver
    rm $tarball
}

if [ ! -d $version ]; then
    download_pkg $version
fi

cd $version
mkdir build-tree

./configure --prefix=$INSTALL_DIR \
    --with-pcre=$DEPS_SRC_DIR/pcre/$pcre_version \
    --add-module=$MODULE_DIR/echo-nginx-module \
    --add-module=$MODULE_DIR/ngx_devel_kit \
    --add-module=$MODULE_DIR/set-misc-nginx-module \
    --add-module=$MODULE_DIR/array-var-nginx-module

make
make install
cd ..
