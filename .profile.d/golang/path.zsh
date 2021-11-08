# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Go path

_LOCAL_SDK="$(local_lib_path go)"
if [[ -d "${_LOCAL_SDK}" ]]; then
    export GOPATH="${_LOCAL_SDK}${GOPATH:+":${GOPATH}"}"
    export GOBIN="${_LOCAL_SDK}/bin"
    path=(${_LOCAL_SDK}/bin $path)
fi
unset _LOCAL_SDK
