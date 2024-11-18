#!/bin/bash

#Install the Smart Security Card Reader Tools:
sudo pacman -Sy opensc ccid pcsc-tools pscslite

#Install SafetyNet Authentication and B-trust Biss:
yay -Sy sac-core sac-gui btrustbiss

#Add Gemelto PKCS11 to the security library
mkdir $HOME/.pki && mkdir $HOME/.pki/nssdb

modutil -add "libIDPrimePKCS11.so" -libfile libIDPrimePKCS11.so -dbdir sql:$HOME/.pki/nssdb -mechanisms FRIENDLY

systemctl enable pcscd.service

systemctl start pcscd.service

echo "Installation completed! Follow instructions for browser support!"
