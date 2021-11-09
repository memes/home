#-*- mode: sh -*-
#
# Load direnv support

if command -v asdf >/dev/null 2>/dev/null; then
    eval "$(asdf exec direnv hook bash)"
elif command -v direnv >/dev/null 2>/dev/null; then
    eval "$(direnv hook bash)"
fi
