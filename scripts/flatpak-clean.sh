#!/bin/bash

# Colors
Gre='\e[0;32m';     
RCol='\e[0m';

echo -e "${Gre}\nUninstalling unused flatpak packages...\n${RCol}"

flatpak uninstall -y --unused

echo -e "${Gre}\nRemoving flatpak cache...\n${RCol}"

sudo rm -rfv /var/tmp/flatpak-cache-*

echo -e "${Gre}\nFlatpak cleaning task completed.\n${RCol}"