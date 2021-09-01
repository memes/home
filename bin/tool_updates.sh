#!/bin/sh
#
# Update various things
if command -v brew 2>/dev/null >/dev/null; then
    brew update
    brew upgrade
    brew cleanup
    brew doctor
fi
if command -v apt 2>/dev/null >/dev/null; then
    sudo apt update
    sudo apt upgrade
fi
antibody update
# Don't try to update GCP SDK on Debian
command -v apt 2>/dev/null >/dev/null || \
    gcloud components update
~/bin/go_refresh.sh
