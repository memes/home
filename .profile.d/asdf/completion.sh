#-*- mode: sh -*-
# shellcheck shell=bash disable=SC1091
#
# If homebrew is on PATH, enable bash completion

if command -v brew > /dev/null 2>/dev/null && \
    [ -f "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash" ]; then
    . "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"
fi
