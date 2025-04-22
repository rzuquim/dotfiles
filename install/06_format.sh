#!/bin/bash

echo -e "${CYAN}Formatting UEFI partition as FAT32...${NC}"
if [[ "$first_disk" == *nvme* ]]; then
    uefi_part="${first_disk}p2"
else
    uefi_part="${first_disk}2"
fi
mkfs.fat -F32 -n "EFI" "$uefi_part"
echo -e "${GREEN}DONE${NC}"

echo -e "${CYAN}Formatting virtual swap volume${NC}"
mkswap /dev/vg0/swap
echo -e "${GREEN}DONE${NC}"

echo -e "${CYAN}Formatting virtual root volume as good old ext4${NC}"
mkfs.ext4 -L "root" /dev/vg0/root
echo -e "${GREEN}DONE${NC}"

echo -e "${CYAN}Mounting the disks and enabling swap:${NC} /mnt /mnt/boot"
mount /dev/vg0/root /mnt
mount --mkdir "$uefi_part" /mnt/boot
swapon /dev/vg0/swap
echo -e "${GREEN}DONE${NC}"

if [[ ${#encrypted_storages[@]} -gt 0 ]]; then
    echo -e "${CYAN}Formatting virtual storage volume as good old ext4${NC}"
    mkfs.ext4 -L "storage" /dev/vg1/storage
    echo -e "${GREEN}DONE${NC}"
fi

echo -e "${VIOLET}Disks prepared and mounted. Ready to install Arch!${NC}"

