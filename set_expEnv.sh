#!/bin/bash
apt update
apt upgrade -y
apt install -y cmake build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git libudev-dev libdb++-dev libdb-dev libcrypto++-dev libqrencode-dev bsdmainutils unzip
git clone https://gitee.com/biparadox/cube-1.3.git
git clone https://gitee.com/biparadox/env_monitor.git
cd cube-1.3
source set_env.sh
sh env_build.sh
cd ../env_monitor
source set_env.sh
cd src
make

cat > ~/.vimrc <<EOF
set number
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
set shiftwidth=2
syntax on

autocmd FilterWritePre * if &diff | setlocal wrap< | endif

set t_Co=256
if ! has("gui_running")
    set t_Co=256
    endif
if &diff
    colors molokai 	"github blue
endif

set laststatus=2 " 显示文件名
EOF

