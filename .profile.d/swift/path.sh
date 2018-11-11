# -*- mode: sh -*-
#
# Swift path setup - not OS X!

_LOCAL_SDK="$(local_lib_path swift)"
if [ -d "${_LOCAL_SDK}" ]; then
    export PATH="${_LOCAL_SDK}/bin${PATH:+":${PATH}"}"
    export LD_LIBRARY_PATH="${_LOCAL_SDK}/lib${LD_LIBRARY_PATH:+":${LD_LIBRARY_PATH}"}"
    export C_INCLUDE_PATH="${_LOCAL_SDK}/include${C_INCLUDE_PATH:+":${C_INCLUDE_PATH}"}"
    export CPLUS_INCLUDE_PATH="${_LOCAL_SDK}/include${CPLUS_INCLUDE_PATH:+":${CPLUS_INCLUDE_PATH}"}"
    export MANPATH="${_LOCAL_SDK}/share/man${MANPATH:+":${MANPATH}"}"
fi
unset _LOCAL_SDK
