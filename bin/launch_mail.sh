#!/bin/sh
# shellcheck disable=all
#
# Launch a browser and open webmail
#EMAIL_SCALING=${EMAIL_SCALING:-1.7}
#chromium --user-data-dir=${HOME}/.config/chromium.mail ${EMAIL_SCALING:+"--force-device-scale-factor=${EMAIL_SCALING}"} > /dev/null 2>/dev/null
google-chrome --user-data-dir=${HOME}/.config/google-chrome.mail ${EMAIL_SCALING:+"--force-device-scale-factor=${EMAIL_SCALING}"} > /dev/null 2>/dev/null
