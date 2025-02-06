# -*- mode: sh -*-
# shellcheck shell=bash
#
# Python path

# Note: python uses .local on linux now, so this will do nothing on recent
# installs
_LOCAL_PYTHON="$(local_lib_path python)"
if [ -d "${_LOCAL_PYTHON}" ] && [ -d "${_LOCAL_PYTHON}/bin" ]; then
    export PYTHON_PATH="${_LOCAL_PYTHON}${PYTHON_PATH:+":${PYTHON_PATH}"}"
    export PATH="${_LOCAL_PYTHON}/bin${PATH:+":${PATH}"}"
fi
unset _LOCAL_PYTHON
