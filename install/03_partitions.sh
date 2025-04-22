#!/bin/bash

# NOTE: we are creating the EFI partition on the end to ensure every LVM partition index is 1 (when multiple disks)
echo -e "${CYAN}Creating LVM partition (everything except last 1GiB) on:${NC} $first_disk"
sgdisk -n1:0:-1GiB -t1:8e00 -c1:LVM "$first_disk"

echo -e "${CYAN}Creating EFI partition (last 1GiB) on:${NC} $first_disk"
sgdisk -n2:-1GiB:0 -t2:ef00 -c2:EFI "$first_disk"

for disk in "${disks[@]:1}"; do
    echo -e "${CYAN}Creating LVM partition on:${NC} $disk"
    sgdisk -n1:0:0 -t1:8e00 -c1:LVM "$disk"
done

for disk in "${storage_disks[@]}"; do
    echo -e "${CYAN}Creating LVM partition on storage disk:${NC} $disk"
    sgdisk -n1:0:0 -t1:8e00 -c1:LVM "$disk"
done
