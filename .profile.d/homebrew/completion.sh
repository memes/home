#-*- mode: sh -*-
# shellcheck shell=bash disable=SC1091
#
# If homebrew is on PATH, enable bash completion

if command -v brew > /dev/null 2>/dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    . "$(brew --prefix)/etc/bash_completion"
fi
