#!/usr/bin/env bash
set -e

echo "======================================"
echo "Installing Hyprland & Noctalia Dots..."
echo "======================================"

# Ensure directories exist
mkdir -p ~/.config
mkdir -p ~/.local/state

# Copy dotfiles
echo "[*] Copying configuration files..."
cp -r .config/* ~/.config/
cp -r .local/* ~/.local/

# Update font cache
echo "[*] Updating font cache for Fontconfig rules..."
fc-cache -f

# Apply Spicetify if it is installed
if command -v spicetify &> /dev/null; then
    echo "[*] Applying Spicetify configuration..."
    spicetify apply || echo "[!] Spicetify apply failed, but continuing..."
else
    echo "[!] Spicetify not found. Skipping Spotify theme apply."
fi

# Apply GTK font via gsettings (if running GNOME/GTK environment)
if command -v gsettings &> /dev/null; then
    echo "[*] Setting GNOME/GTK font preferences..."
    gsettings set org.gnome.desktop.interface font-name 'ProFontIIx Nerd Font 11' || true
    gsettings set org.gnome.desktop.interface document-font-name 'ProFontIIx Nerd Font 11' || true
    gsettings set org.gnome.desktop.interface monospace-font-name 'ProFontIIx Nerd Font 11' || true
fi

echo ""
echo "======================================"
echo "Installation complete!"
echo "Please restart Hyprland, Noctalia, and Kitty to apply all changes."
echo "======================================"
