#-*- mode: sh -*-
#
# If homebrew is on PATH, enable bash completion

command -v brew > /dev/null 2>/dev/null
if [ $? -eq 0 ] && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    . "$(brew --prefix)/etc/bash_completion"
fi
