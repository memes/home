# -*- mode: sh -*-
# shellcheck shell=bash disable=SC1090
#
# Common environment setup

# Default to LA timezone
export TZ="America/Los_Angeles"

# Prefer emacs, but fallback on vi(m) if needed
# shellcheck disable=SC2155
export EDITOR="$(command -v qw 2>/dev/null || command -v emacsclient 2>/dev/null || command -v vi)"
export VISUAL="${EDITOR}"

# If this is Linux, set some properties
if [ "$(uname)" = "Linux" ]; then
    # When using libvirt, default to qemu for system
    export LIBVIRT_DEFAULT_URI=qemu:///system

    # Make Qt use GTK theme
    export QT_QPA_PLATFORMTHEME=qgnomeplatform
fi

# Set a default prompt in case it is not overridden anywhere else
# '<fg green>user@host<reset>:<fg red>pwd<reset>(#|$) '
PS1='\[\033[0;32m\]\u@\h\[\033[0m\]:\[\033[0;31m\]\w\[\033[00m\]\$ '

# Show git status in prompt if git prompt has been added to system
# shellcheck disable=SC2034
if type -t __git_ps1 > /dev/null 2>/dev/null; then
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=
    GIT_PS1_SHOWUPSTREAM="auto verbose"
    GIT_PS1_SHOWCOLORHINTS=1
    PROMPT_COMMAND="__git_ps1 '${PS1%\\\$ }' '\$ '"
fi

# Source my aliases file
[ -f ~/.aliases ] && . ~/.aliases
