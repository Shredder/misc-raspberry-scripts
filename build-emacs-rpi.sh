#!/bin/bash

BUILD_DIR=$HOME/src-opt/
EMACS_VERSION=24.3
EMACS_NAME=emacs-$EMACS_VERSION
EMACS_DIR=$BUILD_DIR/emacs-$EMACS_VERSION/
EMACS_URL=http://ftp.gnu.org/pub/gnu/emacs/emacs-$EMACS_VERSION.tar.bz2
PREFIX=/opt/$EMACS_NAME/
FLAGS=--without-x
CFLAGS="-Ofast -mfpu=vfp -mfloat-abi=hard -march=armv6zk -mtune=arm1176jzf-s"
export CFLAGS

sudo apt-get -y install texinfo libncurses5-dev xz-utils
mkdir -p $BUILD_DIR
curl http://ftp.gnu.org/pub/gnu/emacs/emacs-24.3.tar.xz | tar -xJ -C $BUILD_DIR

cd $EMACS_DIR
./configure --prefix=$PREFIX $FLAGS
make
#sudo make install
