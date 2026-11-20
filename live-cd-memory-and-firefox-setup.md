# Ubuntu Live CD: Optimizing Memory (`zram`) and Media Playback

When running Ubuntu from a Live CD/USB, all newly installed packages, downloads, and browser caches reside in an in-memory `overlayfs` (`/cow`) layer. Without swap space or cache management, heavy browsers like Firefox can trigger the Linux Out-Of-Memory (OOM) killer (`Killed` / `Exiting due to channel error.`) or run out of space on `/cow`.

---

## 1. Quick One-Liner Setup

Run this command right after booting into the Live environment to configure an 8 GB `lz4`-compressed `zram` swap device, tune `vm.swappiness`, and purge residual package caches from `/cow`:

```bash
sudo modprobe zram && sudo swapoff /dev/zram0 2>/dev/null; sudo zramctl --reset /dev/zram0 2>/dev/null; echo lz4 | sudo tee /sys/block/zram0/comp_algorithm >/dev/null && echo 8G | sudo tee /sys/block/zram0/disksize >/dev/null && sudo mkswap /dev/zram0 >/dev/null && sudo swapon -p 100 /dev/zram0 && sudo sysctl -w vm.swappiness=150 >/dev/null && sudo apt clean && sudo rm -rf /var/lib/apt/lists/* /var/log/journal/* && free -h && df -h /
