# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# If homebrew and zsh-completions are installed, add to fpath and prioritize binaries.

if command -v brew >/dev/null 2>/dev/null; then
    _LOCAL_BREW_PREFIX="$(brew --prefix)"
    [[ -d "${_LOCAL_BREW_PREFIX}/bin" ]] && [[ -x "${_LOCAL_BREW_PREFIX}/bin" ]] && \
        path=("${_LOCAL_BREW_PREFIX}/bin" $path)
    _LOCAL_ZSH_COMPLETIONS="${_LOCAL_BREW_PREFIX}/share/zsh-completions"
    [[ -d "${_LOCAL_ZSH_COMPLETIONS}" ]] && \
        fpath=(${_LOCAL_ZSH_COMPLETIONS} $fpath)
    unset _LOCAL_ZSH_COMPLETIONS
    unset _LOCAL_BRE_PREFIX
fi
