#!/bin/sh
#
# Install/update gemini-cli extensions

command -v gemini >/dev/null 2>/dev/null || return 0

awk '!/^($|#)/ {print}' <<EOF |
# Gemini CLI extensions to install
#
# Name Source
code-review https://github.com/gemini-cli-extensions/code-review
gemini-cli-jules https://github.com/gemini-cli-extensions/jules
gemini-cli-security https://github.com/gemini-cli-extensions/security
EOF
while read -r name source; do
    if gemini extensions list | grep -q "Source: ${source}"; then
        gemini extensions update "${name}"
    else
        gemini extensions install --consent "${source}"
    fi
done
