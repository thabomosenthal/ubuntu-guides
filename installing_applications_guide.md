# Installing and Managing Applications on Ubuntu

Ubuntu supports several package and application formats. This guide covers how to install, manage, and completely uninstall software across all major Ubuntu formats.

---

## Quick Reference Summary

| Application Format | Installation Command / Method | Uninstallation Command |
| :--- | :--- | :--- |
| **`.deb` Package** | `sudo apt install ./file.deb` | `sudo apt remove <package-name>` |
| **AppImage** | `chmod +x file.AppImage` then `./file.AppImage` | Delete `.AppImage` file |
| **PPA Repository** | `sudo add-apt-repository ppa:...` | `sudo ppa-purge ppa:...` |
| **Flatpak** | `flatpak install flathub <app-id>` | `flatpak uninstall <app-id>` |
| **Snap Package** | `sudo snap install <package-name>` | `sudo snap remove <package-name>` |
| **Tarball Archive (`.tar.gz` / `.tar.xz`)** | Extract to `/opt/` and set symlinks | Remove binary folder from `/opt/` |

---

## 1. `.deb` Packages (Debian Software Packages)

`.deb` files are traditional Linux software installers (similar to `.exe` or `.msi` on Windows).

### Installation
1. Open your terminal in the directory where the `.deb` file was downloaded (e.g., `cd ~/Downloads`).
2. Install using `apt` (recommended because it automatically resolves dependencies):
   ```bash
   sudo apt install ./filename.deb