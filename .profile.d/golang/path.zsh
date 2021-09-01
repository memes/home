# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Go path

# Is Go 1.17 installed on Debian?
_LOCAL_SDK="/usr/lib/go-1.17"
if [[ -d "${_LOCAL_SDK}/bin" ]]; then
    path=(${_LOCAL_SDK}/bin $path)
fi
_LOCAL_SDK="$(local_lib_path go)"
if [[ -d "${_LOCAL_SDK}" ]]; then
    export GOPATH="${_LOCAL_SDK}${GOPATH:+":${GOPATH}"}"
    export GOBIN="${_LOCAL_SDK}/bin"
    path=(${_LOCAL_SDK}/bin $path)
fi
unset _LOCAL_SDK
