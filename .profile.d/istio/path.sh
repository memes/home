# -*- mode: sh -*-
#
# Add istio binaries to path

_LOCAL_SDK="$(local_lib_path istio)"
if [ -d "${_LOCAL_SDK}/bin" ]; then
    export PATH="${_LOCAL_SDK}/bin${PATH:+":${PATH}"}"
fi
unset _LOCAL_SDK
