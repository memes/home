#!/bin/sh
# shellcheck disable=all

echo '{"version":1,"click_events":false}'
echo '[[]'
while true; do
    echo ',['
    count=0
    icon=""
    docker ps --format="{{.Names}} {{.Status}}" 2>/dev/null | \
	while read name status; do
	    [ ${count} -eq 0 ] && icon=" " || icon=""
	    count=$(($count+1))
	    printf '{"full_text":"%s%s %s","short_text":"%s%s","name":"docker","instance":"%s"},' "${icon}" "${name}" "${status}" "${icon}" "${name}" "${count}" 2>/dev/null
	done
    count=0
    icon=""
    for c in qemu:///system lxc; do
        virsh -c ${c} list --name 2>/dev/null | \
	    while read name; do
		if [ -n "${name}" ]; then
		    [ ${count} -eq 0 ] && icon=" " || icon=""
		    count=$(($count+1))
		    printf '{"full_text":"%s%s","short_text":"%s%s","name":"libvirt","instance":"%s"},' "${icon}" "${name}" "${icon}" "${name}" "${count}" 2>/dev/null
		fi
	    done
    done
    echo '{"full_text":""}]'
    sleep 5
done
echo ',[]]'
exit 0
