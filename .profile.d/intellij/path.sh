# -*- mode: sh -*-
# shellcheck shell=bash
#
# IntelliJ path

if [ -d "${HOME}/intellij" ]; then
    export PATH="${HOME}/intellij/bin${PATH:+":${PATH}"}"
fi
