#!/bin/sh
#
_GOPKGS="github.com/constabulary/gb/... github.com/nsf/gocode github.com/tools/godep github.com/rogpeppe/godef github.com/kisielk/errcheck github.com/cloudflare/cfssl/cmd/..."

# Install packages to same folder as this script
_GOPATH=$(readlink -f `dirname $0`)

# Update packages
while read p; do
    echo -n "Fetching/updating ${p} "
    GOPATH=${_GOPATH} go get -u ${p} && echo "done"
done <<EOF
golang.org/x/tools/cmd/...
github.com/constabulary/gb/...
github.com/nsf/gocode
github.com/tools/godep
github.com/rogpeppe/godef
github.com/kisielk/errcheck
github.com/cloudflare/cfssl/cmd/...
EOF

unset _GOPATH
