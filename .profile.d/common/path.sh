# -*- mode: sh -*-
#
# Add personal bin to path
if [[ -d "${HOME}/bin" ]]; then
    export PATH="${HOME}/bin${PATH:+":${PATH}"}"
fi

# Is there a .local/bin?
if [[ -d "${HOME}/.local/bin" ]]; then
    export PATH="${HOME}/.local/bin${PATH:+":${PATH}"}"
fi
