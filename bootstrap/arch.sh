#!/bin/bash

set -euo pipefail

DOTFILES_REPO=git@github.com:rzuquim/dotfiles.git

# ---------------------------------
# COLORS
# ---------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN="\e[38;2;173;216;230m"
INDIGO="\e[38;2;75;0;130m"
VIOLET="\e[38;2;238;130;238m"
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

if [ ! -t 0 ]; then
    echo "Please run this script interactively."
    echo ". <(curl -sL https://raw.githubusercontent.com/rzuquim/dotfiles/master/bootstrap/arch.sh)"
    exit 1
fi

echo -e "${GREEN}                           _           "
echo -e "${GREEN}                          (_)          "
echo -e "${GREEN}  _ __ _____   _  __ _ _   _ _ _ __ ___  "
echo -e "${YELLOW} | '__|_  / | | |/ _\` | | | | | '_ \` _ \ "
echo -e "${YELLOW} | |   / /| |_| | (_| | |_| | | | | | | |"
echo -e "${RED} |_|  /___|\__,_|\__, |\__,_|_|_| |_| |_|"
echo -e "${RED}                    | |                  "
echo -e "${RED}                    |_|                  ${NC}"

echo "Bootstraping Arch"

# ---------------------------------
# SYSTEM CLOCK
# ---------------------------------
echo -e "${CYAN}Syncing system clock...${NC}"
timedatectl set-ntp true
timedatectl set-timezone Brazil/East

# ---------------------------------
# DISKS
# ---------------------------------
echo -e "${CYAN}Partitioning disks...${NC}"
disks=($(lsblk -dno NAME,MODEL | grep -Ev 'USB|loop' | awk '{print "/dev/"$1}'))

if [[ "${#disks[@]}" -eq 0 ]]; then
    echo "No suitable disks found for installation."
    exit 1
fi

echo -e -n "${CYAN}Using the following disks for installation:${NC} "
echo $disks

read -p "A clean installation will ERASE ALL DATA on the disks. Are you sure? [y/N] " response
response=${response:-N}
if [[ $response =~ ^[Yy]$ ]]; then
    # ---------------------------------
    # PARTITIONS
    # ---------------------------------
    for disk in "${disks[@]}"; do
        echo -e "${CYAN}Erasing disk:${NC} $disk"
        sgdisk --zap-all "$disk"
    done

    first_disk="${disks[0]}"

    # NOTE: we are creating the EFI partition on the end to ensure every LVM partition index is 1
    #       when we have multiple disks
    echo -e "${CYAN}Creating LVM partition (everything except last 1GiB) on:${NC} $first_disk"
    sgdisk -n1:0:-1GiB -t1:8e00 -c1:LVM "$first_disk"

    echo -e "${CYAN}Creating EFI partition (last 1GiB) on:${NC} $first_disk"
    sgdisk -n2:-1GiB:0 -t2:ef00 -c2:EFI "$first_disk"

    for disk in "${disks[@]:1}"; do
        echo -e "${CYAN}Creating LVM partition${NC} $disk"
        sgdisk -n1:0:0 -t1:8e00 -c1:LVM "$disk"
    done

    # NOTE: a reboot might be necessary to reload the partition table (since the partitions are cached by the kernel)
    # for disk in "${disks[@]}"; do
    #     echo -e "${CYAN}Telling kernel to reload partition table${NC}"
    #     partprobe "$disk"
    # done

    # ---------------------------------
    # ENCRYPTION
    # ---------------------------------
    # TODO: use yubikey instead of passphrase
    echo -e "${CYAN}Encrypting LVM partitions with LUKS"
    echo -e "${YELLOW}USE THE SAME PASSPHRASE FOR EVERY DISK!${NC}"

    for i in "${!disks[@]}"; do
        disk="${disks[$i]}"
        # NOTE: assuming partition 1 is the LVM on all disks (see note above placing EFI partition on index 2)
        part="${disk}1"
        mapper_name="cryptlvm$i"

        echo -e "${CYAN}Encrypting ${NC} $part"
        cryptsetup luksFormat "$part"
        cryptsetup open "$part" "$mapper_name"
        crypt_devices+=("/dev/mapper/$mapper_name")
    done
    echo -e "${GREEN}Encrypted partitions: ${NC}$crypt_devices"

    # ---------------------------------
    # LVM VOLUMES (on encrypted container)
    # ---------------------------------
    for dev in "${crypt_devices[@]}"; do
        echo -e "${CYAN}Creating physical volume on ${NC} $dev"
        pvcreate "$dev"
    done

    echo -e "${CYAN}Creating volume group and logical volume${NC}"
    vgcreate vg0 "${crypt_devices[@]}"
    lvcreate -l 100%FREE -n root vg0
    echo -e "${GREEN}DONE${NC}"

    sleep 2 # Wait for partitions to appear

    # ---------------------------------
    # FORMATTING AND MOUNTING
    # ---------------------------------
    echo -e "${CYAN}Formatting UEFI partition as FAT32...${NC}"
    mkfs.fat -F32 "${first_disk}2"
    echo -e "${GREEN}DONE${NC}"

    echo -e "${CYAN}Formatting virtual volume as good old ext4${NC}"
    mkfs.ext4 /dev/vg0/root
    echo -e "${GREEN}DONE${NC}"

    echo -e "${CYAN}Mounting the main disk on /mnt and UEFI on /mnt/boot${NC}"
    mount /dev/vg0/root /mnt
    mkdir /mnt/boot
    mount "${first_disk}2" /mnt/boot
else
    exit 1
fi

echo -e "${VIOLET}Disks prepared and mounted. Ready to install Arch!${NC}"

