#!/bin/sh
#
# Install common go packages to local library
set -e

_GOPATH="${HOME}/go"
mkdir -p "${_GOPATH}"

ECHO="$(which echo)" || "echo"
# Install/update packages
awk '!/^($|#)/ {print}' <<EOF |
# Format of list
#
# package [flag]
#
# VS Code required extensions that aren't installed by ~/.Brewfile
# See https://github.com/golang/vscode-go/blob/master/docs/tools.md
golang.org/x/tools/gopls@latest
github.com/go-delve/delve/cmd/dlv@latest
honnef.co/go/tools/cmd/staticcheck@latest
github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest
github.com/ramya-rao-a/go-outline@latest
github.com/haya14busa/goplay/cmd/goplay@latest
github.com/fatih/gomodifytags@latest
github.com/josharian/impl@latest
github.com/cweill/gotests/gotests@master

# Still need to use this on occasion
golang.org/x/tools/cmd/godoc@latest

# crane and gcrane
github.com/google/go-containerregistry/cmd/crane@latest
github.com/google/go-containerregistry/cmd/gcrane@latest

# gofumpt
mvdan.cc/gofumpt@latest

# Codelabs/claat
github.com/googlecodelabs/tools/claat@latest

# Vulnerability checker
golang.org/x/vuln/cmd/govulncheck@latest
golang.org/x/tools/go/analysis/passes/fieldalignment/cmd/fieldalignment@latest
EOF

while read -r p f; do
    ${ECHO} "Fetching/updating ${p}"
    # shellcheck disable=SC2086
    env GOPATH="${_GOPATH}" go install ${f} ${p} && \
        ${ECHO} "${p} done"
done

unset _GOPATH
