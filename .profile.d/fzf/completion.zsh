#-*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Source ~/.fzf.zsh if present
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

command -v brew >/dev/null 2>/dev/null &&
    _FZF_DIR="$(brew --prefix fzf)/shell"
# Fall back to Debian completion dir
_FZF_DIR="${_FZF_DIR:-/usr/share/doc/fzf/examples}"

# Handle completions and bindings if installed
[ -f "${_FZF_DIR}/key-bindings.zsh" ] && source "${_FZF_DIR}/key-bindings.zsh"
[ -f "${_FZF_DIR}/completion.zsh" ] && source "${_FZF_DIR}/completion.zsh"
unset _FZF_DIR
