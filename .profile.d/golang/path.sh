# -*- mode: sh -*-
#
# Go path

_LOCAL_GOPATH="$(local_lib_path go)"
if [ -d "${_LOCAL_GOPATH}" ]; then
    export GOPATH="${_LOCAL_GOPATH}${GOPATH:+":${GOPATH}"}"
    export PATH="${_LOCAL_GOPATH}/bin${PATH:+":${PATH}"}"
fi
unset _LOCAL_GOPATH
