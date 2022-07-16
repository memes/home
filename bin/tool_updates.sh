#!/bin/sh
#
# Update various things
if command -v brew 2>/dev/null >/dev/null; then
    brew update
    brew upgrade
    brew cleanup
    brew doctor
fi
if command -v apt-get 2>/dev/null >/dev/null; then
    sudo apt-get update
    sudo apt-get upgrade
fi
# Don't try to update GCP SDK on Debian
command -v apt-get 2>/dev/null >/dev/null || \
    gcloud components update
~/bin/go_refresh.sh

# Refresh kpt completion
if command -v kpt 2>/dev/null >/dev/null; then
    kpt completion zsh > ~/.profile.d/functions/_kpt
    mkdir -p ~/.profile.d/kpt && \
        kpt completion bash > ~/.profile.d/kpt/completion.sh
fi
