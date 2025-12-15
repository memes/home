#-*- mode: sh -*-
# shellcheck shell=bash

# If default python is 3.10+ there's nothing left to do
(python3 --version 2>/dev/null || python --version 2>/dev/null) | \
    grep -Eq 'Python[ \t]+3\.1[0-9]' 2>/dev/null && return 0

for v in 3.14 3.13 3.12 3.11 3.10; do
    if command -v brew > /dev/null 2>/dev/null; then
        _SDK_PYTHON="$(brew --prefix)/bin/python{v}"
    elif command -v asdf >/dev/null 2>/dev/null; then
        _SDK_PYTHON="$(asdf which python${v})"
    elif command -v pyenv >/dev/null 2>/dev/null; then
        _SDK_PYTHON="$(pyenv prefix "$(pyenv whence python${v} | sort -nr | head -n 1)")/bin/python"
    else
        _SDK_PYTHON="$(which python${v} 2>/dev/null)"
    fi
    if [ -n "${_SDK_PYTHON}" ] && [ -x "${_SDK_PYTHON}" ]; then
        export CLOUDSDK_PYTHON="${_SDK_PYTHON}"
        break
    fi
done
