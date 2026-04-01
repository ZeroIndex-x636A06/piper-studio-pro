#!/usr/bin/env bash

# Ensure the script is NOT run as root initially (we handle sudo inside)
if [[ $EUID -eq 0 ]]; then
   echo "[!] Please run this script as a normal user, not root/sudo."
   exit 1
fi

echo "======================================"
echo " 🚀 Piper Studio Pro: Full Installer"
echo "======================================"

# 1. DETECT DISTRO & INSTALL SYSTEM DEPS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        arch|cachyos|manjaro)
            echo "[*] Arch-based system detected. Installing dependencies..."
            sudo pacman -S --needed --noconfirm ffmpeg python-gobject libadwaita wget tar
            ;;
        fedora)
            echo "[*] Fedora detected. Installing dependencies..."
            sudo dnf install -y ffmpeg python3-gobject libadwaita wget tar
            ;;
        ubuntu|debian|pop|mint)
            echo "[*] Debian-based system detected. Installing dependencies..."
            sudo apt update
            sudo apt install -y ffmpeg python3-gi gir1.2-adw-1 wget tar
            ;;
        *)
            echo "[!] Unknown distribution. Please ensure ffmpeg, python-gobject, and libadwaita are installed manually."
            ;;
    esac
fi

# 2. INSTALL PIPER BINARY (If missing from /opt/piper)
PIPER_BIN="/opt/piper/piper"
if [ ! -f "$PIPER_BIN" ]; then
    echo "[*] Piper engine not found. Downloading standalone binary..."
    sudo mkdir -p /opt/piper
    
    # Download latest Linux x86_64 release from Rhasspy GitHub
    TEMP_DIR=$(mktemp -d)
    wget -O "$TEMP_DIR/piper.tar.gz" https://github.com/rhasspy/piper/releases/latest/download/piper_amd64.tar.gz
    
    echo "[*] Extracting Piper to /opt/piper..."
    sudo tar -xzf "$TEMP_DIR/piper.tar.gz" -C /opt/piper --strip-components=1
    rm -rf "$TEMP_DIR"
    
    if [ -f "$PIPER_BIN" ]; then
        echo "[✓] Piper engine installed successfully."
    else
        echo "[!] Error: Piper installation failed. Check your internet connection."
        exit 1
    fi
else
    echo "[✓] Piper engine already present at /opt/piper."
fi

# 3. SETUP DIRECTORIES
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"

# 4. INSTALL EXECUTABLE
if [ -f "piper-studio" ]; then
    echo "[*] Installing app to ~/.local/bin..."
    cp piper-studio "$HOME/.local/bin/"
    chmod +x "$HOME/.local/bin/piper-studio"
else
    echo "[!] Error: 'piper-studio' file missing from this folder."
    exit 1
fi

# 5. INSTALL ICON
if [ -f "icon.png" ]; then
    echo "[*] Installing icon..."
    cp icon.png "$HOME/.local/share/icons/com.zeroindex.piperstudio.png"
fi

# 6. GENERATE DESKTOP ENTRY
echo "[*] Creating desktop launcher..."
cat << EOF > "$HOME/.local/share/applications/com.zeroindex.piperstudio.desktop"
[Desktop Entry]
Name=Piper Studio Pro
Comment=High-Fidelity AI Voice Generator
Exec=$HOME/.local/bin/piper-studio
Icon=com.zeroindex.piperstudio
Terminal=false
Type=Application
Categories=AudioVideo;Audio;
StartupNotify=true
EOF

update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null || true

echo "======================================"
echo " ✅ INSTALLATION COMPLETE"
echo " You can now launch Piper Studio Pro!"
echo "======================================"
