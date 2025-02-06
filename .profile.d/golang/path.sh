# -*- mode: sh -*-
# shellcheck shell=bash
#
# Go path

_LOCAL_GOPATH="$(local_lib_path go)"
if [ -d "${_LOCAL_GOPATH}" ]; then
    export GOPATH="${_LOCAL_GOPATH}${GOPATH:+":${GOPATH}"}"
    export GOBIN="${_LOCAL_SDK}/bin"
    export PATH="${_LOCAL_GOPATH}/bin${PATH:+":${PATH}"}"
fi
unset _LOCAL_GOPATH
