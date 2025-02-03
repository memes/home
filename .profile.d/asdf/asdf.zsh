# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Integrate asdf to the shell

if command -v brew >/dev/null 2>/dev/null && test -f "$(brew --prefix asdf)/libexec/asdf.sh"; then
    source "$(brew --prefix asdf)/libexec/asdf.sh"
elif test -f "${HOME}/.asdf/asdf.sh"; then
    source "${HOME}/.asdf/asdf.sh"
fi
