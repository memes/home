#-*- mode: sh -*-
#
# Setup podman

if command -v podman >/dev/null 2>/dev/null; then
    _socket="$(podman machine inspect --format '{{ .ConnectionInfo.PodmanSocket.Path }}' 2>/dev/null)"
    if [ -n "${_socket}" ]; then
        export DOCKER_HOST="unix://${_socket}"
    fi
    export KPT_FN_RUNTIME=podman
    export KIND_EXPERIMENTAL_PROVIDER=podman
fi
