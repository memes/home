# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Common environment setup

# Default to LA timezone
export TZ="America/Los_Angeles"

# Prefer emacs, but fallback on vi(m) if needed
export EDITOR="$(command -v qw 2>/dev/null || command -v emacsclient 2>/dev/null || command -v vi)"
export VISUAL="${EDITOR}"

# If this is Linux, set some properties
if [[ "$(uname)" = "Linux" ]]; then
    # When using libvirt, default to qemu for system
    export LIBVIRT_DEFAULT_URI=qemu:///system

    # Make Qt use GTK theme
    export QT_QPA_PLATFORMTHEME=qgnomeplatform
fi

# Load my shared aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Zsh config
setopt NO_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt INTERACTIVE_COMMENTS
export CLICOLOR=true

# Setup a shared zsh history
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST

# Don't prompt me when I rm with * glob
setopt RM_STAR_SILENT

# Completion settings
setopt AUTO_CD
setopt AUTO_LIST
setopt AUTO_MENU
setopt ALWAYS_TO_END

# forces zsh to realize new commands
zstyle ':completion:*' completer _oldlist _expand _complete _match _ignored _approximate

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# rehash if command not found (possibly recently installed)
zstyle ':completion:*' rehash true

# menu if nb items > 2
zstyle ':completion:*' menu select=2
