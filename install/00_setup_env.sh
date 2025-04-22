#!/bin/bash

all_disks=($(lsblk -dno NAME,MODEL | grep -Ev 'USB|loop' | awk '{print "/dev/"$1}'))
ssds=($(lsblk -dno NAME,MODEL | grep -Ev 'USB|loop|nvme' | awk '{print "/dev/"$1}'))
nvmes=($(lsblk -dno NAME,MODEL | grep 'nvme' | awk '{print "/dev/"$1}'))

if [[ "${#all_disks[@]}" -eq 0 ]]; then
    echo -e "${RED}No suitable disks found for installation.${NC}"
    exit 1
fi

echo -e "${CYAN}Using the following disks for installation${NC} "
if [[ ${#nvmes[@]} -gt 0 ]]; then
    disks=("${nvmes[@]}")
    storage_disks=("${ssds[@]}")
else
    disks=("${ssds[@]}")
    storage_disks=()
fi

first_disk="${disks[0]}"

echo -e "${YELLOW}Main disks:${NC} ${disks[@]}"
echo -e "${YELLOW}Storage disks${NC}: ${storage_disks[@]}"
echo
read -p "A clean installation will ERASE ALL DATA on the disks. Are you sure? [y/N] " response
response=${response:-N}
if [[ ! $response =~ ^[Yy]$ ]]; then
    echo -e "${RED}User aborted installation.${NC}"
    exit 1
fi

echo -e "${YELLOW}Enter a passphrase prefix:${NC}"
echo "(It will be used for disk encryption and for the user's passwords)"
read -s -p "Passphrase: " passphrase
echo
read -s -p "Confirm passphrase: " passphrase_confirm
echo

if [[ "$passphrase" != "$passphrase_confirm" ]]; then
    echo -e "${RED}Passphrases do not match. Aborting.${NC}"
    exit 1
fi

luks_pass="${passphrase}_LUKS"
