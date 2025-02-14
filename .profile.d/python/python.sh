#-*- mode: sh -*-
# shellcheck shell=bash disable=SC1090,SC2155
#
# Python: require a venv by default, add aliases to allow global installation
export PIP_REQUIRE_VIRTUALENV=true
alias global_pip='PIP_REQUIRE_VIRTUALENV="" pip'
alias global_pip2='PIP_REQUIRE_VIRTUALENV="" pip2'
alias global_pip3='PIP_REQUIRE_VIRTUALENV="" pip3'

# Source virtualenvwrapper if found
_VIRTUALENVWRAPPER=$(command -v virtualenvwrapper.sh)
# shellcheck disable=SC2181
if [ $? -eq 0 ]; then
    export WORKON_HOME="${HOME}/.virtualenvs"
    export PROJECT_HOME="${HOME}/projects"
    export VIRTUALENVWRAPPER_PYTHON=$(command -v python3)
    . "${_VIRTUALENVWRAPPER}"
fi
unset _VIRTUALENVWRAPPER

# Support pipenv
command -v pipenv >/dev/null 2>/dev/null && \
    export PIPENV_VENV_IN_PROJECT=1
