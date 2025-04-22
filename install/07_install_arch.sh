#!/bin/bash

echo -e "${CYAN}Installing arch${NC}"

pacstrap -K /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

echo
arch_banner
echo

echo -e "${VIOLET}Arch installed!${NC}"
echo -e "${RED}CHROOT! ${NC}${GREEN}CHROOT! ${NC}${CYAN}CHROOT! ${NC}${YELLOW}CHROOT!${NC}"
