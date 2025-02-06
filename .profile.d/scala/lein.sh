# -*- mode: sh -*-
# shellcheck shell=bash
#
# Scala setup

if [ -d "$(local_lib_path lein)" ]; then
    # shellcheck disable=SC2155
    export LEIN_HOME="$(local_lib_path lein)"
fi
