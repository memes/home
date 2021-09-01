# -*- mode: sh -*-
#
# Go path

# Is Go 1.17 installed on Debian?
_LOCAL_SDK="/usr/lib/go-1.17"
if [ -d "${_LOCAL_SDK}/bin" ]; then
    export PATH="${_LOCAL_SDK}/bin${PATH:+":${PATH}"}"
fi
unset _LOCAL_SDK
_LOCAL_GOPATH="$(local_lib_path go)"
if [ -d "${_LOCAL_GOPATH}" ]; then
    export GOPATH="${_LOCAL_GOPATH}${GOPATH:+":${GOPATH}"}"
    export GOBIN="${_LOCAL_SDK}/bin"
    export PATH="${_LOCAL_GOPATH}/bin${PATH:+":${PATH}"}"
fi
unset _LOCAL_GOPATH
