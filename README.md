# Ubuntu Setup

Script per la configurazione iniziale di Ubuntu.

### Feature
- Upgrade dei pacchetti di sistema
- Installazione di pacchetti utili usando [Nala](https://github.com/volitank/nala)
- Sostituzione di Snap con [Flatpak](https://flatpak.org/) usando lo script [snap-to-flatpak](https://github.com/MasterGeekMX/snap-to-flatpak)
- Installazione di Apps usando [Flatpak](https://flatpak.org/)
- Configurazione del tema [Orchis](https://github.com/vinceliuice/Orchis-theme) per Gnome
- Configurazione delle icone [Numix](https://github.com/numixproject/numix-icon-theme-circle)
- Installazione di [Docker](https://www.docker.com/) e [Portainer](https://www.portainer.io/)
- Configurazione della shell [fish](https://github.com/fish-shell/fish-shell)
- Installazione  servizi in [systemd](https://www.systemd.it/) per l'esecuzione di script personalizzati (cartella [scripts](scripts)).

## Getting started

### Setup iniziale

```bash
git clone https://github.com/Lucass97/ubuntu-setup.git 
cd ubuntu-setup
chmod +x setup.sh
sudo ./setup.sh
```

### Installazione dei servizi
```bash
chmod +x install-services.sh
sudo ./install-services.sh
```
