# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Integrate podman to the shell

if command -v podman >/dev/null 2>/dev/null; then
    export DOCKER_HOST=unix:///${HOME}/.local/share/containers/podman/machine/podman-machine-default/podman.sock
fi
