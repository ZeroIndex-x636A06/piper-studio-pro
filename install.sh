#!/usr/bin/env bash

echo "======================================"
echo " Installing Piper Studio Pro"
echo "======================================"

# 1. Create necessary directories
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"

# 2. Install the main executable
if [ -f "piper-studio" ]; then
    echo "[*] Copying executable to ~/.local/bin..."
    cp piper-studio "$HOME/.local/bin/"
    chmod +x "$HOME/.local/bin/piper-studio"
else
    echo "[!] Error: 'piper-studio' script not found in this directory."
    echo "    Make sure you are running this script from the repository root."
    exit 1
fi

# 3. Install the icon (UPDATED NAME)
if [ -f "icon.png" ]; then
    echo "[*] Copying icon to ~/.local/share/icons..."
    cp icon.png "$HOME/.local/share/icons/com.zeroindex.piperstudio.png"
else
    echo "[!] Warning: 'icon.png' not found. App will use a default fallback icon."
fi

# 4. Generate the Desktop Entry (UPDATED NAME AND ICON)
echo "[*] Generating GNOME Desktop entry..."
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

# 5. Refresh the desktop database
echo "[*] Updating desktop database..."
update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null || true

echo "======================================"
echo " ✓ Installation Complete!"
echo " You can now launch 'Piper Studio Pro' from your app menu."
echo "======================================"
