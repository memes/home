#-*- mode: sh -*-
#
# Load direnv support

if command -v podman >/dev/null 2>/dev/null; then
    export DOCKER_HOST=unix:///${HOME}/.local/share/containers/podman/machine/podman-machine-default/podman.sock
    export KPT_FN_RUNTIME=podman
fi
