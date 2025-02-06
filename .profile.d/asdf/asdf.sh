#-*- mode: sh -*-
# shellcheck shell=bash disable=SC1091
#
# Load asdf support

if command -v brew >/dev/null 2>/dev/null && test -f "$(brew --prefix asdf)/libexec/asdf.sh"; then
    source "$(brew --prefix asdf)/libexec/asdf.sh"
elif test -f "${HOME}/.asdf/asdf.sh"; then
    source "${HOME}/.asdf/asdf.sh"
fi
