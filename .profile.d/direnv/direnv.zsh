# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Integrate direnv to the shell
#  1. install asdf
#  2. asdf plugin add direnv
#  3. asdf install direnv latest
#  4. asdf direnv setup --version latest
#  5. Remove added line from .zshrc/.bashrc

if test -f "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
elif command -v asdf >/dev/null 2>/dev/null; then
    eval "$(asdf exec direnv hook zsh)"
elif command -v direnv >/dev/null 2>/dev/null; then
    eval "$(direnv hook zsh)"
fi
