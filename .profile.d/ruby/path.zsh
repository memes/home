# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Ruby setup

command -v ruby >/dev/null 2>/dev/null && \
    command -v gem >/dev/null 2>/dev/null && \
    path=($(ruby -e 'puts Gem.user_dir')/bin $path)
