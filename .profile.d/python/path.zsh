# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Python path

# Note: python uses .local on linux now, so this will do nothing on recent
# installs
_LOCAL_SDK="$(local_lib_path python)"
if [[ -d "${_LOCAL_SDK}" ]] && [[ -d "${_LOCAL_SDK}/bin" ]]; then
    export PYTHON_PATH="${_LOCAL_SDK}${PYTHON_PATH:+":${PYTHON_PATH}"}"
    path=(${_LOCAL_SDK}/bin $path)
fi
unset _LOCAL_SDK
