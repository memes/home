# Refresh go packages

$pkgs =
  "golang.org/x/oauth2/google",
  "golang.org/x/tools/cmd/godoc",
  "golang.org/x/tools/cmd/goimports",
  "golang.org/x/tools/cmd/gorename",
  "golang.org/x/tools/cmd/guru",
  "github.com/alecthomas/gometalinter",
  "github.com/cloudflare/cfssl/cmd/...",
  "github.com/constabulary/gb/...",
  "github.com/cweill/gotests",
  "github.com/derekparker/delve/cmd/dlv",
  "github.com/gohugoio/hugo",
  "github.com/golang/dep/cmd/dep",
  "github.com/josharian/impl",
  "github.com/nsf/gocode",
  "github.com/rogpeppe/godef",
  "github.com/sourcegraph/go-langserver",
  "github.com/tools/godep",
  "google.golang.org/appengine",
  "google.golang.org/appengine/log",
  "google.golang.org/api/cloudiot/v1";
foreach ($pkg in $pkgs) {
  "Fetching/updating " + $pkg
  go get -u $pkg
}

gometalinter --install