#!/bin/sh
#
# Setup Antigravity CLI
set -e

# If an argument is provided, use it as the source directory for bootstrapped/dotfiles sources.
BOOTSTRAP_SOURCE_DIR="$(readlink -f "${1:-"xxx-does-not-exist-xxx"}")"
TARGET_DIR="$(readlink -f "${2:-"${HOME}"}")"

command -v agy >/dev/null 2>/dev/null || return 0

# Only merge or copy the Antigravity settings if
if [ -r "${BOOTSTRAP_SOURCE_DIR}/.gemini/antigravity-cli/settings.json" ]; then
    if [ -w "${TARGET_DIR}/.gemini/antigravity-cli/settings.json" ]; then
        merged_settings="$(mktemp)"
        jq -s '.[0] + .[1]' \
            "${BOOTSTRAP_SOURCE_DIR}/.gemini/antigravity-cli/settings.json" \
            "${TARGET_DIR}/.gemini/antigravity-cli/settings.json" > "${merged_settings}" && \
        mv -f "${merged_settings}" "${TARGET_DIR}/.gemini/antigravity-cli/settings.json"
    else
        cp "${BOOTSTRAP_SOURCE_DIR}/.gemini/antigravity-cli/settings.json" "${TARGET_DIR}/.gemini/antigravity-cli/settings.json"
    fi
fi
