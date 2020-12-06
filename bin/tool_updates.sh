#!/bin/sh
#
# Update various things
brew update
brew upgrade
brew cleanup
brew doctor
antibody update
gcloud components update
~/bin/go_refresh.sh
