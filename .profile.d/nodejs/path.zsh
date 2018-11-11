# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# NodeJS path and configuration

_LOCAL_SDK="$(local_lib_path node)"
if [[ -d "${_LOCAL_SDK}" ]] && [[ -d "${_LOCAL_SDK}/bin" ]]; then
    export NODE_PATH="${_LOCAL_SDK}${NODE_PATH:+":${NODE_PATH}"}"
    path=(${_LOCAL_SDK}/bin $path)
    cat >| ~/.npmrc <<EOF
prefix=${_LOCAL_SDK}
EOF
fi
unset _LOCAL_SDK
