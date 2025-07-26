#!/bin/bash

#Install the Smart Security Card Reader Tools:
sudo pacman -Sy opensc ccid pcsc-tools pcsclite

#Checking if yay or paru is installed and installing yay if neither is present:
if ! command -v paru >/dev/null 2>&1 && ! command -v yay >/dev/null 2>&1; then
    echo "paru and yay not found. Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
    echo "YAY is installed to be used for AUR package installs."
else
    echo "AUR installer present."
fi

#Install SafetyNet Authentication and B-trust Biss from AUR based on paru or yay present:
if command -v paru >/dev/null 2>&1; then
    paru -Sy sac-core sac-gui btrustbiss
elif command -v yay >/dev/null 2>&1; then
    yay -Sy sac-core sac-gui btrustbiss
else
    echo "Something went wrong. We can't locate AUR package installer."
    exit 1
fi

sudo cp /opt/btrustbiss/lib/btrustbiss-BISS.desktop /usr/share/applications/

#Add Gemelto PKCS11 to the security library
if [ ! -d "$HOME/.pki" ]; then
    mkdir "$HOME/.pki"
fi

if [ ! -d "$HOME/.pki/nssdb" ]; then
    mkdir "$HOME/.pki/nssdb"
fi

modutil -add "libIDPrimePKCS11.so" -libfile libIDPrimePKCS11.so -dbdir sql:$HOME/.pki/nssdb -mechanisms FRIENDLY

sudo systemctl enable --now pcscd.service

sudo systemctl status pcscd.service

echo "Installation completed! Follow instructions for browser support!"
