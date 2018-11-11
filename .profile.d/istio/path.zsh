# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Add istio to path

[[ -d "$(local_lib_path istio/bin)" ]] && \
    path=($(local_lib_path istio/bin) $path)
