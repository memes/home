# -*- mode: sh  -*-
# shellcheck shell=bash
#
# Android SDK

case "$(uname)" in
    Darwin)
        _LOCAL_SDK=$(local_lib_path android-sdk-macosx)
        ;;

    Linux)
        _LOCAL_SDK=$(local_lib_path android-sdk-linux)
        ;;

    *)
        _LOCAL_SDK=$(local_lib_path android-sdk-unknown)
        ;;
esac

if [ -d "${_LOCAL_SDK}/cmdline-tools" ]; then
    export PATH="${_LOCAL_SDK}/cmdline-tools/latest/bin:${_LOCAL_SDK}/platform-tools:${_LOCAL_SDK}/tools${PATH:+":${PATH}"}"
    # Not strictly a path setting, but no point in repeating this in .bashrc
    export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
    export ANDROID_HOME="${_LOCAL_SDK}"
fi
unset _LOCAL_SDK

# Android studio?
if [ -d "${HOME}/android-studio/bin" ]; then
    export PATH="${HOME}/android-studio/bin${PATH:+":${PATH}"}"
fi
