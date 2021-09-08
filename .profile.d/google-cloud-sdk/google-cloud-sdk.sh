#-*- mode: sh -*-
#
if command -v pyenv >/dev/null 2>/dev/null; then
    _PYTHON38="$(pyenv prefix `pyenv whence python3.8 | sort -nr | head -n 1`)/bin/python"
else
    _PYTHON38="$(which python3.8 2>/dev/null)"
fi
if [[ -n "${_PYTHON38}" ]] && [[ -x "${_PYTHON38}" ]]; then
    export CLOUDSDK_PYTHON="${_PYTHON38}"
fi
