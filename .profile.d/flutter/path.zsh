# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Flutter

[[ -d "$(local_lib_path flutter/bin)" ]] && \
    path=($(local_lib_path flutter/bin) $path)
