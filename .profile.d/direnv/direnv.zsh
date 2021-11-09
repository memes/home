# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Integrate direnv to the shell

if command -v asdf >/dev/null 2>/dev/null; then
    eval "$(asdf exec direnv hook zsh)"
elif command -v direnv >/dev/null 2>/dev/null; then
    eval "$(direnv hook zsh)"
fi
