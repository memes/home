# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

# Python: require a virtualenv by default and integrate with shell
export PIP_REQUIRE_VIRTUALENV=true

# Source virtualenvwrapper if found
_VIRTUALENVWRAPPER=$(command -v virtualenvwrapper.sh)
if [ $? -eq 0 ]; then
    export WORKON_HOME="~/.virtualenvs"
    export PROJECT_HOME="~/projects"
    source "${_VIRTUALENVWRAPPER}"
fi
unset _VIRTUALENVWRAPPER
