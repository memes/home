#-*- mode: sh -*-
# shellcheck shell=bash
#
# Setup node for REPL mode with rlwrap
if command -v rlwrap > /dev/null 2> /dev/null; then
    alias node="env NODE_NO_READLINE=1 rlwrap node"
    alias node_repl="node -e \"require('repl').start({ignoreUndefined: true})\""
    export NODE_DISABLE_COLORS=1
fi
