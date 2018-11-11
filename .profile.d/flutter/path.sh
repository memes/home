# -*- mode: sh -*-
#
# Flutter

_LOCAL_SDK="$(local_lib_path flutter)"
if [ -d "${_LOCAL_SDK}" ] && [ -d "${_LOCAL_SDK}/bin)" ]; then
    export PATH="${_LOCAL_SDK}/bin${PATH:+":${PATH}"}"
fi
unset _LOCAL_SDK
