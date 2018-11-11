# -*- mode: sh -*-
#
# Google Cloud SDK setup

_LOCAL_SDK="$(local_lib_path google-cloud-sdk)"
[ -f "${_LOCAL_SDK}/path.bash.inc" ] && . "${_LOCAL_SDK}/path.bash.inc"
unset _LOCAL_SDK
