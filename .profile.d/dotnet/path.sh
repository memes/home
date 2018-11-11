# -*- mode: sh -*-
#
# .NET core

_LOCAL_SDK="$(local_lib_path .net)"
if [ -d "${_LOCAL_SDK}" ]; then
    export PATH="${_LOCAL_SDK}${PATH:+":${PATH}"}"
    if [ -d "${_LOCAL_SDK}/omnisharp" ]; then
        export PATH="${_LOCAL_SDK}/omnisharp${PATH:+":${PATH}"}"
    fi
fi
unset _LOCAL_SDK
