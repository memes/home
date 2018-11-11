# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# If homebrew and zsh-completions are installed, add to fpath

if command -v brew >/dev/null 2>/dev/null; then
    _LOCAL_ZSH_COMPLETIONS="$(brew --prefix)/share/zsh-completions"
    [[ -d "${_LOCAL_ZSH_COMPLETIONS}" ]] && \
        fpath=(${_LOCAL_ZSH_COMPLETIONS} $fpath)
    unset _LOCAL_ZSH_COMPLETIONS
fi
