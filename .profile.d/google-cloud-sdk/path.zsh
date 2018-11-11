# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Google Cloud SDK path setup

_LOCAL_SDK="$(local_lib_path google-cloud-sdk)"
[[ -f "${_LOCAL_SDK}/path.zsh.inc" ]] && \
    source "${_LOCAL_SDK}/path.zsh.inc"
 unset _LOCAL_SDK
