# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Scala setup

[[ -d "$(local_lib_path lein)" ]] && \
    export LEIN_HOME="$(local_lib_path lein)"
