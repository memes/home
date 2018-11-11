# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Add personal bin to path
[[ -d ~/bin ]] && path=(~/bin $path)

# Is there a .local/bin?
[[ -d ~/.local/bin ]]&& path=(~/.local/bin $path)
