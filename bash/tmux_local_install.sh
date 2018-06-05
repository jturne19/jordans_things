#!/bin/bash

# simple script for installing tmux localing without root access
# CentOS 7

# exit on error
set -e

# install everything in ~/.local
DIR=$HOME/.local

mkdir -p $DIR $HOME/tmux_tmp
cd $HOME/tmux_tmp

wget https://github.com/tmux/tmux/releases/download/2.7/tmux-2.7.tar.gz
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
wget ftp://ftp.invisible-island.net/ncurses/ncurses.tar.gz 

## libevent
tar xvzf libevent-2.1.8-stable.tar.gz
cd libevent-2.1.8-stable
./configure --prefix=$DIR --disable-shared
make
make install
cd ..

## ncurses
tar xvzf ncurses.tar.gz
cd ncurses-6.1
./configure --prefix=$DIR
make
make install
cd ..

## tmux
tar xvzf tmux-2.7.tar.gz
cd tmux-2.7
./configure  CFLAGS="-I$DIR/include -I$DIR/include/ncurses" LDFLAGS="-L$DIR/lib -L$DIR/include/ncurses -L$DIR/include"
CPPFLAGS="-I$DIR/include -I$DIR/include/ncurses" LDFLAGS="-static -L$DIR/include -L$DIR/include/ncurses -L$DIR/lib" make
cp tmux $DIR/bin
cd ..

export LD_PRELOAD="$DIR/lib/libevent-2.1.so.6"

echo 'export LD_PRELOAD="$HOME/.local/lib/libevent-2.1.so.6"' >> ~/.bashrc

# clean up
rm -rf $HOME/tmux_tmp

echo "tmux is ready bitch. add $HOME/.local/bin to your PATH if you haven't already"
