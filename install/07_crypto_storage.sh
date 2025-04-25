#!/bin/bash

echo -e "${CYAN}Disk encrypt wrap up${NC}"

mkdir -p /mnt/etc/keys
cp "$keyfile" /mnt/etc/keys/storage.key
chmod 600 /mnt/etc/keys/storage.key

# NOTE: finding out the /root device (we are assuming that the first nvme device will hold the root)
nvmes_disks=$({ blkid -t TYPE=crypto_LUKS | grep nvme; } || true)

if [[ -z "$nvmes_disks" ]]; then
    echo -e "${YELLOW}No NVMe devices found! No /storage partition.${NC}"
    storage_disks=()
    return 0
else
    storage_disks=($({ blkid -t TYPE=crypto_LUKS | sort | grep -Ev nvme | cut -d'"' -f2; } || true))
fi

if [ ! -f  /mnt/etc/crypttab ]; then
    echo -e "${CYAN}Writing /etc/crypttab${NC}"
    touch /mnt/etc/crypttab

    # BUG: this assumes there is only one nvme drive and the cryptlvm0 is assigned to it
    crypt_index=1
    for disk_id in "${storage_disks[@]}"; do
        echo "cryptlvm${crypt_index} UUID=$disk_id /etc/keys/storage.key luks" >> /mnt/etc/crypttab
        crypt_index=$((crypt_index + 1))
    done
fi

