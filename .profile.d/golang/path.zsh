# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Go path

if [[ -d "${HOME}/go" ]]; then
    export GOPATH="${HOME}/go${GOPATH:+":${GOPATH}"}"
    export GOBIN="${HOME}/go/bin"
    path=(${HOME}/go/bin $path)
fi
