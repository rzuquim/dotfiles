#!/bin/bash

echo -e "${CYAN}Encrypting LVM partitions with LUKS"

curr_mapper_name=""
keyfile="/keyfile.bin"

function do_encrypt() {
    local disk=$1
    local luks_pass=$2
    local i=$3

    if [[ -z "$luks_pass" ]]; then
        echo "${RED}LUKS passphrase is empty!${NC}" >&2
        exit 1
    fi

    # NOTE: assuming partition 1 is the LVM on all disks (see note above placing EFI partition on index 2)
    if [[ "$disk" == *nvme* ]]; then
        part="${disk}p1"
    else
        part="${disk}1"
    fi
    mapper_name="cryptlvm$i"

    echo -e "${YELLOW}Encrypting ${NC} $part ${YELLOW}=>${NC} $mapper_name"
    echo -n "$luks_pass" | cryptsetup luksFormat "$part" --batch-mode --key-file=-
    echo -n "$luks_pass" | cryptsetup open "$part" "$mapper_name" --key-file=-

    if [[ "$i" != "0"  ]]; then
        echo "Adding file key on /storage device (input the LUKS passphrase to make sure you known the convention)"
        cryptsetup luksAddKey "$part" "$keyfile"
    fi

    curr_mapper_name="$mapper_name"
}

if [ ! -e $keyfile ]; then
    echo -e "${YELLOW}Generating keyfile...${NC}"
    dd if=/dev/urandom of="$keyfile" bs=1 count=4096
fi

crypt_index=0

for disk in "${disks[@]}"; do
    do_encrypt "$disk" "$luks_pass" "$crypt_index"
    encrypted_disks+=("/dev/mapper/$curr_mapper_name")
    all_crypt_devices+=("/dev/mapper/$curr_mapper_name")
    crypt_index=$((crypt_index + 1))
done

for disk in "${storage_disks[@]}"; do
    do_encrypt "$disk" "$luks_pass" "$crypt_index"
    encrypted_storages+=("/dev/mapper/$curr_mapper_name")
    all_crypt_devices+=("/dev/mapper/$curr_mapper_name")
    crypt_index=$((crypt_index + 1))
done

echo -e "${GREEN}Encrypted disks: ${NC}${encrypted_disks[@]}"
echo -e "${GREEN}Encrypted storages: ${NC}${encrypted_storages[@]}"
