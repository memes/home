# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Google Cloud SDK completion

_LOCAL_SDK="$(local_lib_path google-cloud-sdk)"
[[ -f "${_LOCAL_SDK}/completion.zsh.inc" ]] && \
    source "${_LOCAL_SDK}/completion.zsh.inc"
unset _LOCAL_SDK
