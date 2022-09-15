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

echo -e "${BBlu}
----------------------------
|   Ubuntu script setup    |
|   Author: Luca Gregori   |
----------------------------
${RCol}"

read -p "Press enter to continue"

echo -e "${Gre}\nUpgrading system...\n${RCol}"

sudo apt update
sudo apt install -y nala

sudo nala upgrade -y

echo -e "${Gre}\nInstalling basic packages using nala...\n${RCol}"

sudo nala install -y htop bashtop tre-command git python3-pip python3-venv

echo -e "${Gre}"
read -r -p "Remove snap and install flatpak? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	echo -e "${Gree}\nExecuting Snap-to-Flatpak script...\n${RCol}"
	git clone https://github.com/MasterGeekMX/snap-to-flatpak.git
	chmod +x snap-to-flatpak/snap-to-flatpak.sh
	./snap-to-flatpak.sh
else
    echo -e "${Red}\nSkipping...\n${RCol}"
fi

#--------------------------------------------------------------------------

if ! command -v flatpak &> /dev/null 
then
	echo -e "${Red}\nflatpak could not be found\n${RCol}"
else
	echo -e "${Gre}\nInstalling browsers via flatpak...\n${RCol}"

	sudo flatpak install -y flathub org.mozilla.firefox org.chromium.Chromium

	echo -e "${Gre}\nInstalling IDEs via flatpak...\n${RCol}"

	sudo flatpak install -y flathub com.jetbrains.PyCharm-Professional com.visualstudio.code

	echo -e "${Gre}\nInstalling social apps via flatpak...\n${RCol}"

	sudo flatpak install -y flathub com.discordapp.Discord org.telegram.desktop com.microsoft.Teams

	echo -e "${Gre}"
	read -r -p "Install other apps? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		echo -e "${Gre}\nInstalling other apps via flatpak...\n${RCol}"

		sudo flatpak install -y flathub org.gnome.Weather \
			org.gnome.Calendar \
			org.gnome.Photos \
			com.mattjakeman.ExtensionManager \
			org.videolan.VLC \
			io.github.shiftey.Desktop \
			net.cozic.joplin_desktop \
			org.libreoffice.LibreOffice \
			net.mediaarea.MediaInfo \
			org.qbittorrent.qBittorrent \
			com.github.hugolabe.Wike \
			com.raggesilver.BlackBox
	else
   		echo -e "${Red}\nSkipping...\n${RCol}"
	fi
fi

#--------------------------------------------------------------------------

echo -e "${Gre}"
read -r -p "Install docker? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	echo -e "${Gre}\nInstalling docker...\n${RCol}"
	
	sudo nala install -y \
    	ca-certificates \
    	curl \
    	gnupg \
    	lsb-release
	
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  		$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	sudo nala update
	sudo nala install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
	
	echo -e "${Gre}\nInstalling portainer...$\n${RCol}"

	sudo docker volume create portainer_data
	sudo docker run -d -p 8000:8000 -p 9443:9443 -p 9000:9000 --name portainer \
		--restart=always \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v portainer_data:/data \
		portainer/portainer-ce:latest

else
    echo -e "${Red}\nSkipping...\n${RCol}"
fi

#--------------------------------------------------------------------------

echo -e "${Gre}"
read -r -p "Customize Gnome Shell? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	echo -e "${Gre}\nSetup Orchis theme...\n${RCol}"
	git clone https://github.com/vinceliuice/Orchis-theme.git
	chmod +x Orchis-theme/install.sh
	./Orchis-theme/install.sh -t all

	gsettings set org.gnome.desktop.interface gtk-theme 'Orchis-Orange-Dark'
	gsettings set org.gnome.desktop.wm.preferences theme 'Orchis-Orange-Dark'

	sudo add-apt-repository ppa:numix/ppa
	sudo nala update
	sudo nala install -y numix-icon-theme-circle

	gsettings set org.gnome.desktop.interface icon-theme 'Numix-Circle'

else
    echo -e "${Red}\nSkipping...\n${RCol}"
fi

#--------------------------------------------------------------------------

echo -e "${Gre}"
read -r -p "Install Fish Shell? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	echo -e "${Gre}\nInstalling fish...\n${RCol}"
	sudo nala install -y fish
	chsh -s /usr/local/bin/fish

	sudo cp fish-config/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
	sudo cp fish-config/tree.fish ~/.config/fish/functions/tre.fish

else
    echo -e "${Red}\nSkipping...\n${RCol}"
fi

echo -e "${Gre}\nSetup completed...\n${RCol}"
