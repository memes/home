# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Google Cloud SDK completion

command -v brew > /dev/null && \
    _LOCAL_SDK=$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
[[ -d "${_LOCAL_SDK}" ]] || _LOCAL_SDK=$(local_lib_path google-cloud-sdk)
[[ -f "${_LOCAL_SDK}/completion.zsh.inc" ]] && \
    source "${_LOCAL_SDK}/completion.zsh.inc"
unset _LOCAL_SDK
