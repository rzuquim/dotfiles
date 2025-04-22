#!/bin/bash

echo -e "${YELLOW}Syncing system clock...${NC}"
timedatectl set-ntp true
timedatectl set-timezone Brazil/East

