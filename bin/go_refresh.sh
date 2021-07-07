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
github.com/fatih/gomodifytags
github.com/godoctor/godoctor
#github.com/haya14busa/gopkgs/cmd/gopkgs
github.com/uudashr/gopkgs/v2/cmd/gopkgs
github.com/josharian/impl
github.com/zmb3/gogetdoc
gopkg.in/check.v1
github.com/ramya-rao-a/go-outline
github.com/newhook/go-symbols
github.com/haya14busa/goplay/cmd/goplay

# Utilities
github.com/ckaznocha/protoc-gen-lint

# crane and gcrane
github.com/google/go-containerregistry/cmd/crane
github.com/google/go-containerregistry/cmd/gcrane
EOF

while read p m f; do
    ${ECHO} "Fetching/updating ${p}"
    env GOPATH=${_GOPATH} ${m:+"GO111MODULE=${m}"} go get ${f} ${p} && \
        ${ECHO} "${p} done"
done

unset _GOPATH
