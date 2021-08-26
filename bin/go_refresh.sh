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
# package [flag]
#
# VS Code required extensions that aren't installed by ~/.Brewfile
# See https://github.com/golang/vscode-go/blob/master/docs/tools.md
github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest
github.com/ramya-rao-a/go-outline
github.com/haya14busa/goplay/cmd/goplay
github.com/fatih/gomodifytags
github.com/josharian/impl
github.com/cweill/gotests/...

# Still need to use this on occasion
golang.org/x/tools/cmd/godoc

# crane and gcrane
github.com/google/go-containerregistry/cmd/crane
github.com/google/go-containerregistry/cmd/gcrane
EOF

while read p f; do
    ${ECHO} "Fetching/updating ${p}"
    env GOPATH=${_GOPATH} go get ${f} ${p} && \
        ${ECHO} "${p} done"
done

unset _GOPATH
