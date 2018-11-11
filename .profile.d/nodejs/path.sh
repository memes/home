# -*- mode: sh -*-
#
# NodeJS path setup

_LOCAL_NODE="$(local_lib_path node)"
if [ -d "${_LOCAL_NODE}" ] && [ -d "${_LOCAL_NODE}/bin" ]; then
    export NODE_PATH="${_LOCAL_NODE}${NODE_PATH:+":${NODE_PATH}"}"
    export PATH="${_LOCAL_NODE}/bin${PATH:+":${PATH}"}"
    cat >| ${HOME}/.npmrc <<EOF
prefix=${_LOCAL_NODE}
EOF
fi
unset _LOCAL_NODE
