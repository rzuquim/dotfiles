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

# ------------
# system clock
# ------------
echo -e "${CYAN}Syncing system clock...${NC}"
timedatectl set-ntp true
timedatectl set-timezone Brazil/East

# ------------
# disks
# ------------
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
    # Partition the first disk: 1GiB EFI + rest for LVM
    first_disk="${disks[0]}"
    echo -e "${CYAN}Erasing disk:${NC} $first_disk"
    sgdisk --zap-all "$first_disk"

    echo -e "${CYAN}Creating EFI partition on:${NC} $first_disk"
    sgdisk -n1:0:+1GiB -t1:ef00 -c1:EFI "$first_disk"

    echo -e "${CYAN}Creating LVM partition on:${NC} $first_disk"
    sgdisk -n2:0:0     -t2:8e00 -c2:LVM "$first_disk"

    # Partition remaining disks as LVM only
    for disk in "${disks[@]:1}"; do
        echo -e "${CYAN}Erasing disk:${NC} $disk"
        sgdisk --zap-all "$disk"
        echo -e "${CYAN}Creating LVM partition on:${NC} $disk"
        sgdisk -n1:0:0 -t1:8e00 -c1:LVM "$disk"
    done

    echo -e -n "${CYAN}Formatting UEFI partition as FAT32...${NC}"
    sleep 2 # Wait for partitions to appear
    mkfs.fat -F32 "${first_disk}1"
    echo -e "${GREEN}DONE${NC}"

    echo -e "${CYAN}Creating physical volumes for LVM on ${NC} ${first_disk}2"
    pvcreate "${first_disk}2"

    for disk in "${disks[@]:1}"; do
        echo -e "${CYAN}Creating physical volumes for LVM on ${NC} ${disk}1"
        pvcreate "${disk}1"
    done

    echo -e "${CYAN}Creating volume group and logical volume${NC}"
    vgcreate vg0 "${first_disk}2" # TODO: add more disks
    lvcreate -l 100%FREE -n root vg0

    echo -e "${CYAN}Formatting virtual volume as good old ext4${NC}"
    mkfs.ext4 /dev/vg0/root
    echo -e "${CYAN}Mounting the main disk on /mnt and UEFI on /mnt/boot${NC}"
    mount /dev/vg0/root /mnt
    mkdir /mnt/boot
    mount "${first_disk}1" /mnt/boot
else
    exit 1
fi

echo -e "${VIOLET}Disks prepared and mounted. Ready to install Arch!${NC}"

