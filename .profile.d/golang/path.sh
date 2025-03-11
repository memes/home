# -*- mode: sh -*-
# shellcheck shell=bash
#
# Go path

if [ -d "${HOME}/go" ]; then
    export GOPATH="${HOME}/go${GOPATH:+":${GOPATH}"}"
    export GOBIN="${HOME}/go/bin"
    export PATH="${HOME}/go/bin${PATH:+":${PATH}"}"
fi
