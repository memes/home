# Refresh go packages

$pkgs =
  "golang.org/x/tools/cmd/goimports",
  "golang.org/x/tools/cmd/gorename",
  "golang.org/x/tools/cmd/guru",
  "github.com/constabulary/gb/...",
  "github.com/derekparker/delve/cmd/dlv",
  "github.com/golang/dep/cmd/dep",
  "github.com/kisielk/errcheck",
  "github.com/nsf/gocode",
  "github.com/rogpeppe/godef",
  "github.com/tools/godep";

foreach ($pkg in $pkgs) {
  "Fetching/updating " + $pkg
  go get -u $pkg
}
