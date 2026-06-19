#-*- mode: sh -*-
# shellcheck shell=bash disable=SC1091
#
# Source ~/.fzf.bash if present
if [ -n "${BASH_VERSION}" ] && [ -f "${HOME}/.fzf.bash" ]; then
    source "${HOME}/.fzf.bash"
fi

command -v brew >/dev/null 2>/dev/null &&
    _FZF_DIR="$(brew --prefix fzf)/shell"
# Fall back to Debian completion dir
_FZF_DIR="${_FZF_DIR:-/usr/share/doc/fzf/examples}"

# Handle completions and bindings if installed
if [ -n "${BASH_VERSION}" ]; then
    [ -f "${_FZF_DIR}/key-bindings.bash" ] && source "${_FZF_DIR}/key-bindings.bash"
    [ -f "${_FZF_DIR}/completion.bash" ] && source "${_FZF_DIR}/completion.bash"
fi
unset _FZF_DIR
