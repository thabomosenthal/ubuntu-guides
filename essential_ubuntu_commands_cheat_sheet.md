# Essential Ubuntu Terminal Commands Cheat Sheet

This guide covers the fundamental commands every Ubuntu user should know for navigating the system, managing files, installing software, and monitoring performance.

---

## 1. File and Directory Navigation
These commands help you move around your file system and see what's inside.

* **`pwd`** (Print Working Directory): Shows the exact path of the directory you are currently in.
  ```bash
  pwd
  ```
* **`ls`** (List): Shows the contents of the current directory.
  ```bash
  ls -la     # Lists all files (including hidden ones) with detailed info
  ls -lh     # Lists with human-readable file sizes
  ```
* **`cd`** (Change Directory): Move to a different folder.
  ```bash
  cd /var/log    # Moves to /var/log
  cd ..          # Moves up one directory level
  cd ~           # Moves back to your Home directory
  ```

---

## 2. File and Folder Management
Create, copy, move, and delete files or folders.

* **`mkdir`** (Make Directory): Creates a new folder.
  ```bash
  mkdir my_new_folder
  ```
* **`touch`**: Creates an empty file or updates the timestamp of an existing one.
  ```bash
  touch document.txt
  ```
* **`cp`** (Copy): Copies files or directories.
  ```bash
  cp file.txt backup.txt         # Copies a file
  cp -r folder/ backup_folder/   # Copies a folder and its contents recursively
  ```
* **`mv`** (Move): Moves or renames files and directories.
  ```bash
  mv old_name.txt new_name.txt   # Renames a file
  mv file.txt /Documents/        # Moves a file into the Documents folder
  ```
* **`rm`** (Remove): Deletes files or directories. **Use with caution!**
  ```bash
  rm file.txt          # Deletes a file
  rm -r folder_name    # Deletes a folder and everything inside it
  sudo rm -rf /folder  # Forcefully deletes a protected folder (DANGEROUS)
  ```

---

## 3. Package Management (Installing Software)
Ubuntu primarily uses `apt` (Advanced Package Tool) and `snap` to manage software.

* **Update your system:** (Always do this before installing new software)
  ```bash
  sudo apt update       # Fetches the latest list of available software
  sudo apt upgrade      # Installs the available updates
  ```
* **Manage APT packages (Debian/Ubuntu format):**
  ```bash
  sudo apt install vlc    # Installs the VLC media player
  sudo apt remove vlc     # Uninstalls the software
  apt search vlc          # Searches for software in the repository
  ```
* **Manage Snap packages (Containerized universal format):**
  ```bash
  sudo snap install vlc   # Installs the snap version of VLC
  snap list               # Shows all installed snap packages
  ```

---

## 4. System Information and Monitoring
Check how your system is performing and what hardware you have.

* **`top` / `htop`**: Displays a live, updating list of running processes (like Task Manager). `htop` is more colorful and user-friendly (install via `sudo apt install htop`).
  ```bash
  htop
  ```
* **`df`** (Disk Free): Checks how much storage space is left on your drives.
  ```bash
  df -h    # The '-h' makes it human-readable (GB/MB instead of blocks)
  ```
* **`free`**: Shows available and used RAM (Memory).
  ```bash
  free -m  # Shows memory in Megabytes
  ```
* **`uname`**: Prints system information.
  ```bash
  uname -a # Shows kernel version, architecture, and system hostname
  ```

---

## 5. Working with Archives
Essential for dealing with compressed files (like the Firefox download you did earlier).

* **Tar Archives (`.tar.gz`, `.tar.xz`, `.tar.bz2`)**:
  ```bash
  tar -cvf archive.tar folder/       # Creates a tar archive
  tar -xvf archive.tar               # Extracts a tar archive
  tar -xzvf archive.tar.gz -C /path  # Extracts a gzip tar to a specific path
  ```
* **Zip Archives**:
  ```bash
  sudo apt install unzip    # Make sure unzip is installed
  unzip archive.zip         # Extracts a zip file
  ```

---

## 6. Permissions and Ownership
Linux is a multi-user system, so managing who can read, write, or execute files is critical.

* **`sudo`** (SuperUser Do): Runs a command with administrative (root) privileges.
* **`chmod`** (Change Mode): Changes file permissions (Read/Write/Execute).
  ```bash
  chmod +x script.sh   # Makes a script executable
  ```
* **`chown`** (Change Owner): Changes the owner of a file or directory.
  ```bash
  sudo chown ubuntu:ubuntu file.txt  # Changes owner and group to 'ubuntu'
  ```

---

## 7. Networking
Quickly check your network status or download files.

* **`ping`**: Tests your connection to the internet or another server.
  ```bash
  ping google.com     # Press Ctrl+C to stop
  ```
* **`ip a`**: Shows your IP addresses and network interfaces.
  ```bash
  ip a
  ```
* **`wget`**: Downloads files directly from the web.
  ```bash
  wget https://example.com/file.zip
  ```