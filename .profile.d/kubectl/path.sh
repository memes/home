# -*- mode: sh  -*-
# shellcheck shell=bash
#
# Kubectl and add-ins

# Krew
if [ -d "${HOME}/.krew/bin" ]; then
    export PATH="${HOME}/.krew/bin${PATH:+":${PATH}"}"
fi
