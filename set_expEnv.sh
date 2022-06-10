#!/bin/bash
apt update
apt upgrade -y
apt install -y cmake build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git libudev-dev libdb++-dev libdb-dev libcrypto++-dev libqrencode-dev bsdmainutils unzip
mkdir -p /root/centoscloud/
cd /root/centoscloud/
git clone https://gitee.com/biparadox/cube-1.3.git

git clone https://gitee.com/biparadox/cube_tcmplugin.git
git clone https://gitee.com/biparadox/cube-tcm.git
git clone https://gitee.com/biparadox/cube-gmsmtest.git
git clone https://gitee.com/biparadox/cube-userdefine.git
git clone https://gitee.com/biparadox/gm_sm2_master.git



cd /root/
git clone https://gitee.com/tsosc/env_monitor.git

cd /root/centoscloud/cube_tcmplugin/
source set_env.sh
sh env_build.sh
cd /root/centoscloud/cube_tcm/
source set_env.sh
sh env_build.sh
cd /root/centoscloud/cube-gmsmtest/
source set_env.sh
sh env_build.sh
cd /root/centoscloud/cube-userdefine/
source set_env.sh
sh env_build.sh
cd /root/centoscloud/gm_sm2_master/
source set_env.sh
sh env_build.sh





cd /root/env_monitor
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

