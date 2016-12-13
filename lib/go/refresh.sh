#!/bin/sh
#

# Install packages to same folder as this script
case "$(uname)" in
    Darwin)
        _GOPATH="$(stat -f'%N' `dirname $0`)"
        ;;

    Linux)
        _GOPATH="$(readlink -f `dirname $0`)"
        ;;

    *)
        _GOPATH="does/not/exist"
        ;;
esac

# Update packages
while read p; do
    echo -n "Fetching/updating ${p} "
    GOPATH=${_GOPATH} go get -u ${p} && echo "done"
done <<EOF
golang.org/x/tools/cmd/goimports
github.com/constabulary/gb/...
github.com/nsf/gocode
github.com/tools/godep
github.com/rogpeppe/godef
github.com/kisielk/errcheck
github.com/cloudflare/cfssl/cmd/...
EOF

unset _GOPATH
