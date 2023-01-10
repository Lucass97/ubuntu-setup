#!/bin/bash

# Colors
Red='\e[0;31m';     
BRed='\e[1;31m'; 
BIRed='\e[1;91m';
Gre='\e[0;32m';     
BGre='\e[1;32m';
BBlu='\e[1;34m';
BWhi='\e[1;37m';
RCol='\e[0m';

echo -e "${BWhi}\nChecking sudo permission...\n${RCol}"

if [[ "$EUID" = 0 ]]; then
    echo -e "${BBlu}Already root!n${RCol}"
else
    sudo -k
    if sudo true; then
        echo -e "${BBlu}Correct password!\n${RCol}"
    else
        echo -e "${BRed}Wrong password!\n${RCol}"
        exit 1
    fi
fi

echo -e "${Gre}\nInstalling flatpak-clean service...\n${RCol}"

chmod +x ./scripts/flatpak-clean.sh

sudo cp -r ./scripts /home/luca/utils/scripts 

sudo cp /home/luca/utils/scripts/flatpak-clean.service /etc/systemd/system/flatpak-clean.service 

sudo systemctl start flatpak-clean.service 

sudo systemctl enable flatpak-clean.service 

echo -e "${Gre}\nflatpak-clean service installed.\n${RCol}"