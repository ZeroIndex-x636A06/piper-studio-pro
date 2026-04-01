#!/usr/bin/env bash

echo "======================================"
echo " Uninstalling Piper Studio Pro"
echo "======================================"

# 1. Remove the executable
if [ -f "$HOME/.local/bin/piper-studio" ]; then
    echo "[-] Removing executable from ~/.local/bin..."
    rm -f "$HOME/.local/bin/piper-studio"
fi

# 2. Remove the desktop entry
if [ -f "$HOME/.local/share/applications/com.zeroindex.piperstudio.desktop" ]; then
    echo "[-] Removing GNOME Desktop entry..."
    rm -f "$HOME/.local/share/applications/com.zeroindex.piperstudio.desktop"
fi

# 3. Remove the icon
if [ -f "$HOME/.local/share/icons/com.zeroindex.piperstudio.png" ]; then
    echo "[-] Removing icon..."
    rm -f "$HOME/.local/share/icons/com.zeroindex.piperstudio.png"
fi

echo ""
# 4. Interactive prompt for voice models
VOICE_DIR="$HOME/.local/share/piper/voices"
if [ -d "$VOICE_DIR" ]; then
    read -p "Do you also want to delete all downloaded voice models? [y/N]: " choice
    case "$choice" in
        y|Y )
            echo "[-] Deleting voice models from $VOICE_DIR..."
            rm -rf "$VOICE_DIR"
            ;;
        * )
            echo "[*] Keeping voice models safe in $VOICE_DIR."
            ;;
    esac
fi

echo ""
# 5. Refresh the desktop database so the app disappears from the menu
echo "[*] Updating desktop database..."
update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null || true

echo "======================================"
echo " ✓ Uninstallation Complete."
echo "======================================"
