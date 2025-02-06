#-*- mode: sh -*-
# shellcheck shell=bash disable=SC1091
#
# Source ~/.fzf.bash if present
if [ -n "${BASH_VERSION}" ] && [ -f "${HOME}/.fzf.bash" ]; then
    source "${HOME}/.fzf.bash"
fi
# Handle completions and bindings if Debian package is installed
if [ -n "${BASH_VERSION}" ] && [ -d /usr/share/doc/fzf/examples ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
    source /usr/share/doc/fzf/examples/completion.bash
fi
