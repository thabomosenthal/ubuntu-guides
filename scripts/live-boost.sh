#!/usr/bin/env bash
set -e

# Enable 8 GB lz4-compressed zram swap in physical RAM
modprobe zram
swapoff /dev/zram0 2>/dev/null || true
zramctl --reset /dev/zram0 2>/dev/null || true
echo lz4 > /sys/block/zram0/comp_algorithm
echo 8G > /sys/block/zram0/disksize
mkswap /dev/zram0 >/dev/null
swapon -p 100 /dev/zram0

# Prioritize compressing idle RAM pages into zram
sysctl -w vm.swappiness=150 >/dev/null

# Purge apt caches and systemd journal logs from /cow
apt clean
rm -rf /var/lib/apt/lists/* /var/log/journal/*

# Verify memory and /cow usage
free -h
df -h /

#! Make it executable and run it
#! chmod +x live-boost.sh
#! sudo ./live-boost.sh
