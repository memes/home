# -*- mode: sh -*-
# shellcheck shell=bash
#
# Ruby setup

if command -v ruby >/dev/null 2>/dev/null && \
    command -v gem >/dev/null 2>/dev/null; then
    # shellcheck disable=SC2155
    export PATH="$(ruby -e 'puts Gem.user_dir')/bin${PATH:+":${PATH}"}"
fi
