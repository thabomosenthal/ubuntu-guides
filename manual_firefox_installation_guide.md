# How to Manually Install a Specific Version of Firefox on Ubuntu

This guide covers how to install a specific version of Mozilla Firefox (e.g., `157.0`) manually using the official binaries, bypassing Snap and APT.

## Step 1: Download the Specific Firefox Build
First, download the official `.tar.xz` (or `.tar.bz2`) archive directly from Mozilla's release server. 

*(Note: Replace `157.0` with your exact target version in the URL and file names below)*

```bash
wget https://ftp.mozilla.org/pub/firefox/releases/157.0/linux-x86_64/en-US/firefox-157.0.tar.xz
```

## Step 2: Extract the Archive to /opt
Extract the downloaded file directly into the `/opt` directory to make it accessible system-wide.

* If you downloaded a `.tar.xz` file, use the `-xJf` or `-xvf` flags:
```bash
sudo tar -xvf firefox-157.0.tar.xz -C /opt/
```
* If you downloaded a `.tar.bz2` file, use the `-xjvf` flags:
```bash
sudo tar -xjvf firefox-157.0.tar.bz2 -C /opt/
```

## Step 3: Set Up the Executable Symlink
Create a symbolic link so you can launch this exact Firefox build directly from your terminal. *(Prerequisite: this will overwrite existing apt/snap links in `/usr/local/bin` if they exist).*

```bash
sudo ln -sf /opt/firefox/firefox /usr/local/bin/firefox
```

## Step 4: Create a Desktop Launcher (Optional but Recommended)
To make the browser appear in your Ubuntu app menu or dock, create a custom `.desktop` entry:

```bash
sudo cat <<EOF | sudo tee /usr/share/applications/firefox-custom.desktop
[Desktop Entry]
Version=1.0
Name=Firefox (Manual Install)
Comment=Browse the Web
Exec=/opt/firefox/firefox %u
Terminal=false
Type=Application
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;
StartupWMClass=firefox
EOF
```

## Step 5: Run the Application
You can now run your manually installed Firefox in two ways:

**From the Terminal:**
Since you created the symlink in Step 3, simply type:
```bash
firefox &
```
*(The `&` runs it in the background so you can continue using the terminal).*

**From the GUI:**
Press the Super (Windows) key, search for **Firefox (Manual Install)**, and click to open it.

## Step 6: Verify the Installation
To confirm the correct version is running from the correct location, run:
```bash
/opt/firefox/firefox --version
which firefox
```