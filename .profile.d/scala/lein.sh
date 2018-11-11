# -*- mode: sh -*-
#
# Scala setup

if [ -d "$(local_lib_path lein)" ]; then
    export LEIN_HOME="$(local_lib_path lein)"
fi
