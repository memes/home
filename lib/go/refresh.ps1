# Refresh go packages

$pkgs =
  "golang.org/x/tools/cmd/goimports",
  "golang.org/x/tools/cmd/gorename",
  "golang.org/x/tools/cmd/guru",
  "github.com/constabulary/gb/...",
  "github.com/derekparker/delve/cmd/dlv",
  "github.com/gohugoio/hugo",
  "github.com/golang/dep/cmd/dep",
  "github.com/golang/lint",
  "github.com/kisielk/errcheck",
  "github.com/nsf/gocode",
  "github.com/rogpeppe/godef",
  "github.com/tools/godep",
  "gopkg.in/alecthomas/gometalinter.v1";

foreach ($pkg in $pkgs) {
  "Fetching/updating " + $pkg
  go get -u $pkg
}
