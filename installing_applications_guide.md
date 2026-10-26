# Installing and Managing Applications on Ubuntu

Ubuntu supports several package and application formats. This guide covers how to install, manage, and completely uninstall software across all major Ubuntu formats.

---

## Quick Reference Summary

| Application Format | Installation Command / Method | Uninstallation Command |
| :--- | :--- | :--- |
| .deb Package | sudo apt install ./file.deb | sudo apt remove <package-name> |
| AppImage | chmod +x file.AppImage then ./file.AppImage | Delete .AppImage file |
| PPA Repository | sudo add-apt-repository ppa:... | sudo ppa-purge ppa:... |
| Flatpak | flatpak install flathub <app-id> | flatpak uninstall <app-id> |
| Snap Package | sudo snap install <package-name> | sudo snap remove <package-name> |
| Tarball Archive (.tar.gz / .tar.xz) | Extract to /opt/ and set symlinks | Remove binary folder from /opt/ |

---

## 1. .deb Packages (Debian Software Packages)

.deb files are traditional Linux software installers (similar to .exe or .msi on Windows).

### Installation
1. Open your terminal in the directory where the .deb file was downloaded (e.g., cd ~/Downloads).
2. Install using apt (recommended because it automatically resolves dependencies):
   sudo apt install ./filename.deb
   (Alternatively, using dpkg: sudo dpkg -i filename.deb, followed by sudo apt install -f if dependencies fail).

### Uninstallation
* Remove application:
  sudo apt remove package-name
* Remove application AND global configuration files:
  sudo apt purge package-name
* Clean up orphaned dependencies:
  sudo apt autoremove

---

## 2. AppImages (Portable Executables)

AppImages run without system installation. Everything the app needs is bundled into a single file.

### Installation / Setup
1. Move the downloaded .AppImage file to a dedicated folder (e.g., ~/Applications).
2. Make the file executable:
   chmod +x filename.AppImage
3. Run it directly:
   ./filename.AppImage

### Uninstallation
1. Delete the .AppImage file itself:
   rm ~/Applications/filename.AppImage
2. Remove any local data/config folders stored in ~/.config/ or ~/.cache/ if desired.

---

## 3. PPAs (Personal Package Archives)

PPAs allow software developers to distribute software directly to Ubuntu users via APT repositories.

### Installation
1. Add the PPA repository:
   sudo add-apt-repository ppa:user/ppa-name
2. Update repository lists:
   sudo apt update
3. Install the package:
   sudo apt install package-name

### Uninstallation
* Method 1: Safely revert software using ppa-purge (Recommended)
  sudo apt install ppa-purge
  sudo ppa-purge ppa:user/ppa-name
* Method 2: Manually remove the PPA source
  sudo add-apt-repository --remove ppa:user/ppa-name
  sudo apt update

---

## 4. Flatpaks (Universal Sandboxed Apps)

Flatpak is an application sandboxing environment. Apps are hosted on repositories like Flathub ([https://flathub.org](https://flathub.org)).

### Installation
flatpak install flathub app.id.name
Example: flatpak install flathub org.gimp.GIMP

### Uninstallation
* Uninstall the app:
  flatpak uninstall app.id.name
* Remove unused dependencies and runtimes:
  flatpak uninstall --unused

---

## 5. Snap Packages (Ubuntu Default Sandboxed Packages)

Snap is Ubuntu's default containerized package management system.

### Installation
sudo snap install package-name

### Uninstallation
sudo snap remove package-name

---

## 6. Tarball Archives (.tar.gz / .tar.xz)

Standalone compiled binaries distributed as archives (e.g., Firefox manual installs).

### Installation
1. Extract into /opt/:
   sudo tar -xvf archive-name.tar.xz -C /opt/
2. Symlink binary executable:
   sudo ln -sf /opt/appname/binary /usr/local/bin/appname

### Uninstallation
1. Remove the symlink:
   sudo rm /usr/local/bin/appname
2. Delete the application directory from /opt/:
   sudo rm -rf /opt/appname
3. Remove desktop launcher (if created):
   sudo rm /usr/share/applications/appname.desktop
