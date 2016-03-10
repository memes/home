#!/bin/sh

[ -n "${BLOCK_BUTTON}" ] && notify-send "${BLOCK_BUTTON} ${BLOCK_NAME} ${BLOCK_INSTANCE}"

echo '{"version":1,"click_events":true}'
echo '[[],'
while true; do
    echo '['
    docker ps --no-trunc 2>/dev/null | awk 'BEGIN {FS=" {2,}"} NR > 1 {if($NF > 1) {printf "{\"full_text\":\"%s: %s\",\"short_text\":\"%s\",\"name\":\"docker\",\"instance\":\"%s\"},", $NF, $(NF-2), $NF, $NF}}' 2>/dev/null
    for c in qemu:///system lxc; do
        virsh -c ${c} list 2>/dev/null | awk 'BEGIN {FS=" {2,}"} NR > 2 {if($NF > 1) {printf "{\"full_text\":\"%s: %s\",\"short_text\":\"%s\",\"name\":\"kvm\",\"instance\":\"%s\"},", $(NF-1), $NF, $(NF-1), $(NF-1)}}' 2>/dev/null
    done
    echo '{"full_text":""}],'
    sleep 5
done
echo '[]]'
exit 0
