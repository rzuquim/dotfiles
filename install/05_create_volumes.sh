#!/bin/bash

for dev in "${all_crypt_devices[@]}"; do
    echo -e "${CYAN}Creating physical volume on ${NC} $dev"
    pvcreate "$dev"
done

echo -e "${CYAN}Creating volume group and logical volume for disk${NC}"
vgcreate vg0 "${encrypted_disks[0]}"

for disk in "${encrypted_disks[@]:1}"; do
    vgextend vg0 "$disk"
done

if [[ ${#encrypted_storages[@]} -gt 0 ]]; then
    echo -e "${CYAN}Creating volume group and logical volume for storage${NC}"
    vgcreate vg1 "${encrypted_storages[0]}"

    for disk in "${encrypted_storages[@]:1}"; do
        vgextend vg1 "$disk"
    done
fi

# NOTE: using a chat GPT suggested heuristic for the swap size (assuming we won't use hybernation)
mem_total_mb=$(grep MemTotal /proc/meminfo | awk '{print int($2 / 1024)}')
if [ "$mem_total_mb" -le 2048 ]; then
    swap_size_mb=$((mem_total_mb * 2))
elif [ "$mem_total_mb" -le 8192 ]; then
    swap_size_mb=$((mem_total_mb))
else
    swap_size_mb=8192
fi

echo -e "${CYAN}Creating swap logical volume of${NC} $swap_size_mb ${CYAN} for a memory of ${NC} ${mem_total_mb}MB"
lvcreate -L "${swap_size_mb}M" -n swap vg0

echo -e "${CYAN}Creating root logical volume"
lvcreate -l 100%FREE -n root vg0
echo -e "${GREEN}DONE${NC}"

if [[ ${#encrypted_storages[@]} -gt 0 ]]; then
    lvcreate -l 100%FREE -n storage vg1
    echo -e "${GREEN}DONE${NC}"
fi
echo -e "${CYAN}Creating storage logical volume"

sleep 2 # Wait to ensure volumes are available
