# Ubuntu Live CD: Optimizing Memory (`zram`) and Media Playback

When running Ubuntu from a Live CD/USB, all newly installed packages, downloads, and browser caches reside in an in-memory `overlayfs` (`/cow`) layer. Without swap space or cache management, heavy browsers like Firefox can trigger the Linux Out-Of-Memory (OOM) killer (`Killed` / `Exiting due to channel error.`) or run out of space on `/cow`.

---

## 1. Quick One-Liner Setup

Run this command right after booting into the Live environment to configure an 8 GB `lz4`-compressed `zram` swap device, tune `vm.swappiness`, and purge residual package caches from `/cow`:

```bash
sudo modprobe zram && sudo swapoff /dev/zram0 2>/dev/null; sudo zramctl --reset /dev/zram0 2>/dev/null; echo lz4 | sudo tee /sys/block/zram0/comp_algorithm >/dev/null && echo 8G | sudo tee /sys/block/zram0/disksize >/dev/null && sudo mkswap /dev/zram0 >/dev/null && sudo swapon -p 100 /dev/zram0 && sudo sysctl -w vm.swappiness=150 >/dev/null && sudo apt clean && sudo rm -rf /var/lib/apt/lists/* /var/log/journal/* && free -h && df -h /
```

## 2. Reusable Setup Script (`live-boost.sh`)

Save this script to a persistent USB drive or repository to initialize zram and clean /cow in one step:

```bash
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
```

Make it executable and run it:

```bash
    chmod +x live-boost.sh
    sudo ./live-boost.sh
```

## 3. Fixing Media Playback Errors in Manually Installed Firefox

If a manually extracted Firefox tarball throws ``NS_ERROR_DOM_MEDIA_FATAL_ERR (0x806e0005)`` or `[GFX1-]: Managed to allocate after flush.`:

##### 1. Install `ffmpeg` and clear cached `.deb` files immediately:
```bash
    sudo apt update && sudo apt install -y ffmpeg && sudo apt clean
```
##### 2. Disable Hardware Acceleration & Disk Cache in Firefox:
- Open `about:preferences → Performance → uncheck` Use recommended performance settings and uncheck Use hardware acceleration when available.

- Open `about:config` → set `browser.cache.disk.enable` to `false` (prevents Firefox from filling the `/cow` RAM overlay with disk cache).

##### 3. Optional — Offload Firefox Binaries/Profile to `/tmp`:

 - `/tmp` has its own dedicated `tmpfs` quota separate from `/cow`. Moving an extracted Firefox folder to `/tmp/firefox` keeps `/cow` usage low.
