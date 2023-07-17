#!/bin/bash
#
#**************************************************
# Author:         AGou-ops                        *
# E-mail:         agou-ops@foxmail.com            *
# Date:           2023-07-17                      *
# Description:                              *
# Copyright 2023 by AGou-ops.All Rights Reserved  *
#**************************************************
#
set -euxo pipefail

nightly_release="https://github.com/neovim/neovim/archive/refs/tags/nightly.tar.gz"

curl -o ./neovim-nightly.tar.gz -L $nightly_release

tar xf neovim-nightly.tar.gz

cd neovim-nightly

#
#    } else if (first_level == 1) {
#      symbol = wp->w_p_fcs_chars.foldsep;
#    } else if (first_level + i <= 9) {
#      symbol = '0' + first_level + i;
#    } else {
#      symbol = '>';

start_line=$(awk '/else if \(first_level == 1\)/ {print NR}' src/nvim/drawline.c)
end_line=$(($start_line + 3))

sed -i '' "${start_line},${end_line}d" src/nvim/drawline.c

replace_line=$(($start_line + 1))

sed -i '' "${replace_line}s@.*@      symbol = wp->w_p_fcs_chars.foldsep;@" src/nvim/drawline.c

make CMAKE_BUILD_TYPE=Release

sudo make install

echo "++++++++++++++++++++++++++"
which nvim
echo "++++++++++++++++++++++++++"
