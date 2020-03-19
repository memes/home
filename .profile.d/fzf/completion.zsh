#-*- mode: sh -*-
#
# Source ~/.fzf.zsh if present
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
# Handle completions and bindings if Debian package is installed
[[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh
