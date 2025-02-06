#-*- mode: sh -*-
# shellcheck shell=bash disable=SC1090
#
# If kubectl is installed, enable completion

# Load kubectl completion
command -v kubectl >/dev/null 2>/dev/null && \
    source <(kubectl completion bash)
