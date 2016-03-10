#!/bin/sh
#
# Simple volume controls for PulseAudio, suitable for use in OpenBox keybindings
#

# echos the default sink to use for volume control to stdout
get_default_sink()
{
    pacmd dump 2>/dev/null | awk '/^set-default-sink/ {print $2}' 2>/dev/null
}

# mutes the supplied sink
mute()
{
    local sink=
    [ $# -ge 1 ] && sink="$1"
    [ -z "${sink}" ] && return 1
    pactl set-sink-mute ${sink} 1
}

# unmutes the supplied sink
unmute()
{
    local sink=
    [ $# -ge 1 ] && sink="$1"
    [ -z "${sink}" ] && return 1
    pactl set-sink-mute ${sink} 0
}

# change the volume of sink by amount specified and unmute
change_volume()
{
    local sink=
    [ $# -ge 1 ] && sink="$1"
    [ -z "${sink}" ] && return 1
    local delta=
    [ $# -ge 2 ] && delta="$2"
    [ -n "${sink}" -a -n "${delta}" ] && unmute "${sink}" && \
        pactl -- set-sink-volume "${sink}" "${delta}"
}

# increases the volume of the supplied sink
volume_up()
{
    local sink=
    [ $# -ge 1 ] && sink="$1"
    [ -z "${sink}" ] && return 1
    local delta="+3%"
    [ $# -ge 2 ] && delta="$2"
    [ -n "${sink}" -a -n "${delta}" ] && change_volume "${sink}" "${delta}"
}


# decreases the volume of the supplied sink
volume_down()
{
    local sink=
    [ $# -ge 1 ] && sink="$1"
    [ -z "${sink}" ] && return 1
    local delta="-3%"
    [ $# -ge 2 ] && delta="$2"
    [ -n "${sink}" -a -n "${delta}" ] && change_volume "${sink}" "${delta}"
}

# toggle mute state
toggle_mute()
{
    local sink=
    [ $# -ge 1 ] && sink="$1"
    [ -z "${sink}" ] && return 1
    local state=$(pacmd dump 2>/dev/null | awk "/^set-sink-mute ${sink}/ {print \$3}" 2>/dev/null)
    case "${state}" in
        "no")
             pactl set-sink-mute ${sink} 1
             ;;
        "yes")
             pactl set-sink-mute ${sink} 0
             ;;
        *)
            ;;
    esac
}

# Handle the user arguments
if [ $# -ge 2 ]; then
    sink="$2"
else
    sink=$(get_default_sink)
fi
case "$1" in
    increase)
        volume_up ${sink}
        ;;
    decrease)
        volume_down ${sink}
        ;;
    mute)
        mute ${sink}
        ;;
    unmute)
        unmute ${sink}
        ;;
    toggle)
	toggle_mute ${sink}
	;;
    *)
	echo "Usage: $0 (increase|decrease|mute|unmute|toggle) [sink]"
	exit 1
	;;
esac
return 0
