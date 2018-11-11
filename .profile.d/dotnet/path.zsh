# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# .NET core SDK path

_LOCAL_SDK="$(local_lib_path .net)"
[[ -d "${_LOCAL_SDK}" ]] && path=(${_LOCAL_SDK} $path)
[[ -d "${_LOCAL_SDK}/omnisharp" ]] && path=(${_LOCAL_SDK}/omnisharp $path)
unset _LOCAL_SDK
