#!/bin/bash

echo -e "${CYAN}Installing arch${NC}"

if [ ! -e /mnt/etc/fstab ]; then
    pacstrap -K /mnt base linux linux-firmware
    genfstab -U /mnt >> /mnt/etc/fstab

    if [ ${#storage_disks[@]} -gt 0 ] && ! grep -q "/dev/mapper/vg1-storage" /mnt/etc/fstab; then
        echo -e "${CYAN}Adding /storage to /etc/fstab${NC}"
        if [ -e /dev/mapper/vg1-storage ]; then
            mkdir -p /mnt/storage
            storage_uuid=$(blkid -s UUID -o value /dev/mapper/vg1-storage)
            echo "# /dev/mapper/vg1-storage LABEL=storage" >> /mnt/etc/fstab
            echo "UUID=$storage_uuid /storage ext4 defaults 0 2" >> /mnt/etc/fstab
        else
            echo -e "${RED}vg1-storage not found! ABORTING${NC}"
            exit 1
        fi
    fi

    echo
    arch_banner
    echo

    echo -e "${VIOLET}Arch installed!${NC}"
    echo -e "${RED}CHROOT! ${NC}${GREEN}CHROOT! ${NC}${CYAN}CHROOT! ${NC}${YELLOW}CHROOT!${NC}"
else
    echo -e "${YELLOW}Arch already installed.${NC}"
fi
