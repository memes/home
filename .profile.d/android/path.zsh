# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Android SDK path

case "$(uname)" in
    Darwin)
        _LOCAL_SDK=$(local_lib_path android-sdk-macosx)
        ;;

    Linux)
        _LOCAL_SDK=$(local_lib_path androd-sdk-linux)
        ;;

    *)
        _LOCAL_SDK=$(local_lib_path android-sdk-unknown)
        ;;
esac

if [[ -d "${_LOCAL_SDK}/cmdline-tools" ]]; then
    path=(${_LOCAL_SDK}/cmdline-tools/latest/bin ${_LOCAL_SDK}/platform-tools ${_LOCAL_SDK}/tools $path)
    # Not strictly speaking a 'path' assignment, but do it here anyway
    # export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
    export ANDROID_HOME="${_LOCAL_SDK}"
fi
unset _LOCAL_SDK

# Android studio?
[[ -d ~/android-studio/bin ]] && \
    path=(~/android-studio/bin $path)
