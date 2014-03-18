#!/bin/bash

ver=8.31
if [[ $# -eq 1 ]]; then
    ver=$1
fi
echo "building pcre $ver"

function download_pkg()
{
    ver=$1
    fname=pcre-$ver
    tarball=$fname.tar.bz2
    wget http://downloads.sourceforge.net/project/pcre/pcre/$ver/$tarball
    tar -jxf $tarball
    mv $fname $ver
    rm $tarball
}

if [ ! -d $ver ]; then
    download_pkg $ver
fi

cd $ver
./configure --prefix=$PWD/build-tree
make 
make install
cd ..
