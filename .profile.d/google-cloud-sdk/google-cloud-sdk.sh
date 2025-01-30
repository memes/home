#-*- mode: sh -*-
#
if command -v brew > /dev/null 2>/dev/null; then
    _SDK_PYTHON="$(brew --prefix)/bin/python3.11"
elif command -v asdf >/dev/null 2>/dev/null; then
    _SDK_PYTHON="$(asdf which python3.8)"
elif command -v pyenv >/dev/null 2>/dev/null; then
    _SDK_PYTHON="$(pyenv prefix `pyenv whence python3.8 | sort -nr | head -n 1`)/bin/python"
else
    _SDK_PYTHON="$(which python3.8 2>/dev/null)"
fi
if [ -n "${_SDK_PYTHON}" ] && [ -x "${_SDK_PYTHON}" ]; then
    export CLOUDSDK_PYTHON="${_SDK_PYTHON}"
fi
