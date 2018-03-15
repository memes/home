#!/bin/sh
#
# Install common go packages to local GOPATH
case "$(uname)" in
    Darwin)
        _GOPATH="${HOME}/Library/go"
        ;;

    Linux)
        _GOPATH="${HOME}/lib/go"
        ;;

    *)
        _GOPATH="does/not/exist"
        ;;
esac

mkdir -p ${_GOPATH}

ECHO="$(which echo)" || "echo"
# Update packages
while read p; do
    ${ECHO} -n "Fetching/updating ${p} "
    GOPATH=${_GOPATH} go get -u ${p} && ${ECHO} "done"
done <<EOF
golang.org/x/oauth2/google
golang.org/x/tools/cmd/goimports
golang.org/x/tools/cmd/gorename
golang.org/x/tools/cmd/guru
github.com/cloudflare/cfssl/cmd/...
github.com/constabulary/gb/...
github.com/derekparker/delve/cmd/dlv
github.com/gohugoio/hugo
github.com/golang/dep/cmd/dep
github.com/golang/lint
github.com/kisielk/errcheck
github.com/nsf/gocode
github.com/rogpeppe/godef
github.com/tools/godep
gopkg.in/alecthomas/gometalinter.v1
google.golang.org/appengine
google.golang.org/appengine/log
google.golang.org/api/cloudiot/v1beta1
EOF

unset _GOPATH
