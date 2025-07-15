#!/bin/bash

# Color codes
RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

echo -e "${RED}=========================================="
echo -e "!!! WARNING: SELF DESTRUCT ACTIVATED !!!"
echo -e "==========================================${NC}"
echo
echo -e "${YELLOW}This will WIPE THE ENTIRE DISK your system is running from."
echo -e "It will be UNRECOVERABLE and UNBOOTABLE.${NC}"
echo
echo -e "${CYAN}Starting in 10 seconds... (CTRL+C to abort)${NC}"
sleep 10

# Find the root partition, then strip to get the disk
ROOT_PART=$(findmnt -n -o SOURCE /)
ROOT_DEV=$(echo "$ROOT_PART" | sed 's/[0-9]*$//')

echo
echo -e "${GREEN}Detected root partition:${NC} $ROOT_PART"
echo -e "${GREEN}Will wipe entire disk device:${NC} $ROOT_DEV"
echo

echo -e "${CYAN}Wiping in 5 seconds... (CTRL+C to abort)${NC}"
sleep 5

# Wipe it
echo -e "${RED}Commencing shred on $ROOT_DEV...${NC}"
shred -v -n 3 "$ROOT_DEV"

sync

echo
echo -e "${RED}Self-destruct complete. Powering off...${NC}"
poweroff
