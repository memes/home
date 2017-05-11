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
golang.org/x/tools/cmd/gorename
golang.org/x/tools/cmd/guru
github.com/cloudflare/cfssl/cmd/...
github.com/constabulary/gb/...
github.com/golang/dep/...
github.com/kisielk/errcheck
github.com/nsf/gocode
github.com/rogpeppe/godef
github.com/tools/godep
EOF

unset _GOPATH
