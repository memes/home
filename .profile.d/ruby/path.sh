# -*- mode: sh -*-
#
# Ruby setup

command -v ruby >/dev/null 2>/dev/null && \
    command -v gem >/dev/null 2>/dev/null
if [ $? -eq 0 ]; then
    export PATH="$(ruby -e 'puts Gem.user_dir')/bin${PATH:+":${PATH}"}"
fi
