# -*- mode: sh -*-
#
# rust path

if [ -d "${HOME}/.cargo/bin" ]; then
    export PATH="${HOME}/.cargo/bin${PATH:+":${PATH}"}"
fi
