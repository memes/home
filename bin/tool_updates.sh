#!/bin/sh
#
# Update various things
if command -v brew 2>/dev/null >/dev/null; then
    brew update
    brew upgrade --yes
    brew cleanup
    brew doctor
fi
if command -v apt 2>/dev/null >/dev/null; then
    sudo sh -c 'apt update && apt upgrade --yes && apt dist-upgrade --yes && apt autoremove --yes'
fi
# Don't try to update GCP SDK on Debian
command -v apt-get 2>/dev/null >/dev/null || \
    gcloud components update --yes
~/bin/go_refresh.sh

# Refresh kpt completion
if command -v kpt 2>/dev/null >/dev/null; then
    kpt completion zsh > ~/.profile.d/functions.zsh/_kpt
    mkdir -p ~/.profile.d/kpt && \
        kpt completion bash > ~/.profile.d/kpt/completion.sh
fi
