# -*- mode: sh -*-
#
# Add istioctl completion if the file is present

# Currently, istioctl doesn't support generating a zsh completion file
# This config does nothing yet.
_LOCAL_SDK="$(local_lib_path istio)"
if [ -f "${_LOCAL_SDK}/istioctl.zsh" ]; then
    source "${_LOCAL_SDK}/istioctl.zsh"
fi
unset _LOCAL_SDK
