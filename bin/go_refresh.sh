#!/bin/sh
#
# Install common go packages to local GOPATH
set -e
command -v local_lib_path >/dev/null 2>/dev/null || . ~/.profile.d/functions/local_lib_path

_GOPATH=$(local_lib_path go)
mkdir -p ${_GOPATH}

ECHO="$(which echo)" || "echo"
# Install/update packages
awk '!/^($|#)/ {print}' <<EOF |
# Format of list
#
# package [GO111MODULE flag]
#
# Coding tools
golang.org/x/tools/cmd/godoc
golang.org/x/tools/cmd/goimports
golang.org/x/tools/cmd/gorename
golang.org/x/tools/cmd/gotype
golang.org/x/tools/cmd/guru
#github.com/mdempsky/gocode
github.com/stamblerre/gocode
github.com/rogpeppe/godef
github.com/cweill/gotests/...
github.com/davidrjenni/reftools/cmd/fillstruct
github.com/derekparker/delve/cmd/dlv
github.com/fatih/gomodifytags
github.com/godoctor/godoctor
github.com/golangci/golangci-lint/cmd/golangci-lint
#github.com/haya14busa/gopkgs/cmd/gopkgs
github.com/uudashr/gopkgs/cmd/gopkgs
github.com/josharian/impl
github.com/zmb3/gogetdoc
gopkg.in/check.v1

# LSP implementation
github.com/sourcegraph/go-langserver

# Utilities
github.com/cloudflare/cfssl/cmd/... off
github.com/gohugoio/hugo
github.com/golang/dep/cmd/dep off
EOF

while read p m; do
    ${ECHO} "Fetching/updating ${p}"
    env GOPATH=${_GOPATH} ${m:+"GO111MODULE=${m}"} go get -u ${p} && \
        ${ECHO} "${p} done"
done

unset _GOPATH
