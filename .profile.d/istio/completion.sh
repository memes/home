# -*- mode: sh -*-
#
# Add istioctl completion if the file is present

_LOCAL_SDK="$(local_lib_path istio)"
if [ -f "${_LOCAL_SDK}/istioctl.bash" ]; then
    . "${_LOCAL_SDK}/istioctl.bash"
fi
unset _LOCAL_SDK
