# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

# Python: require a virtualenv by default and integrate with shell
export PIP_REQUIRE_VIRTUALENV=true
alias global_pip='PIP_REQUIRE_VIRTUALENV="" pip'
alias global_pip2='PIP_REQUIRE_VIRTUALENV="" pip2'
alias global_pip3='PIP_REQUIRE_VIRTUALENV="" pip3'

# Source virtualenvwrapper if found
_VIRTUALENVWRAPPER=$(command -v virtualenvwrapper.sh)
if [ $? -eq 0 ]; then
    export WORKON_HOME="~/.virtualenvs"
    export PROJECT_HOME="~/projects"
    export VIRTUALENVWRAPPER_PYTHON=$(command -v python3)
    source "${_VIRTUALENVWRAPPER}"
fi
unset _VIRTUALENVWRAPPER

# Support pipenv
command -v pipenv >/dev/null 2>/dev/null && \
    export PIPENV_VENV_IN_PROJECT=1
