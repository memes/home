#-*- mode: sh -*-
#
# Source ~/.fzf.bash if present
if [ -n "${BASH_VERSION}" ] && [ -f "${HOME}/.fzf.bash" ]; then
    source "${HOME}/.fzf.bash"
fi
