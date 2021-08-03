# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
#  rust path

if [ -d "${HOME}/.cargo/bin" ]; then
    path=(${HOME}/.cargo/bin $path)
fi
