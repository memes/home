#!/bin/sh
#
# Install common go packages to local library
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

# Non-module support gocode - see last lines for module supported gocode
github.com/mdempsky/gocode

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
github.com/ramya-rao-a/go-outline
github.com/newhook/go-symbols

# LSP implementation(s)
github.com/sourcegraph/go-langserver
golang.org/x/tools/gopls@latest on

# Utilities
github.com/cloudflare/cfssl/cmd/... off
github.com/golang/dep/cmd/dep off
github.com/golang/protobuf/protoc-gen-go
github.com/ckaznocha/protoc-gen-lint

# gcrane
github.com/google/go-containerregistry/cmd/gcrane on
EOF

while read p m f; do
    ${ECHO} "Fetching/updating ${p}"
    env GOPATH=${_GOPATH} ${m:+"GO111MODULE=${m}"} go get ${f} ${p} && \
        ${ECHO} "${p} done"
done

# Module-savvy gocode installed as gocode-gomod
env GOPATH=${_GOPATH} go get -d -u github.com/stamblerre/gocode
env GOPATH=${_GOPATH} go build -o ${_GOPATH}/bin/gocode-gomod github.com/stamblerre/gocode

unset _GOPATH
