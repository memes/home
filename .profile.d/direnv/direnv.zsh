# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Integrate direnv to the shell

command -v direnv >/dev/null 2>/dev/null && \
    eval "$(direnv hook zsh)"
