#-*- mode: sh -*-
# shellcheck shell=bash disable=SC1091
#
# Load direnv support

if test -f "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/bashrc"; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/bashrc"
elif command -v asdf >/dev/null 2>/dev/null; then
    eval "$(asdf exec direnv hook bash)"
elif command -v direnv >/dev/null 2>/dev/null; then
    eval "$(direnv hook bash)"
fi
