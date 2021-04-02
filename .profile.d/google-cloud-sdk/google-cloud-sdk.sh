#-*- mode: sh -*-
#
if command -v brew >/dev/null 2>/dev/null; then
    export CLOUDSDK_PYTHON=$(brew --prefix python@3.8)/bin/python3.8
fi
