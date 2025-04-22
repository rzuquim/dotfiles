#!/bin/bash

for disk in "${all_disks[@]}"; do
    echo -e "${YELLOW}Erasing disk:${NC} $disk"
    sgdisk --zap-all "$disk"
    wipefs --all "$disk"
done
