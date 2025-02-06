#-*- mode: sh -*-
# shellcheck shell=bash
#
# Load gpg if it is not already running with SSH support

if command -v gpgconf >/dev/null 2>/dev/null; then
    # Kill existing SSH agent, if it is running
    killall ssh-agent 2>/dev/null >/dev/null
    unset SSH_AGENT_PID

    # Use GPG for SSH agent
    # shellcheck disable=SC2155
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

    # Make sure gpg-agent is running; does nothing if it is already running
    gpg-connect-agent /bye 2>/dev/null >/dev/null
    # shellcheck disable=SC2155
    export GPG_TTY=$(tty)
fi
