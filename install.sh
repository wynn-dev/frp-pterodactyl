#!/bin/bash
HOME="/home/container"

bold=$(echo -en "\e[1m")
nc=$(echo -en "\e[0m")
lightblue=$(echo -en "\e[94m")
lightgreen=$(echo -en "\e[92m")
clear

if [[ -f "./installed" ]]; then
    echo "Starting FRP server"
    ./frps -c ./config.ini
else
    echo "Downloading files for PteroVM"
    curl -sSLo ptero-vm.zip https://cdn2.mythicalkitten.com/pterodactylmarket/ptero-vm/ptero-vm.zip
    curl -sSLo apth https://cdn2.mythicalkitten.com/pterodactylmarket/ptero-vm/apth
    curl -sSLo unzip https://raw.githubusercontent.com/afnan007a/Ptero-vm/main/unzip
    chmod +x apth
    echo "Installing the files"
    ./apth unzip >/dev/null 
    linux/usr/bin/unzip ptero-vm.zip
    linux/usr/bin/unzip root.zip
    tar -xf root.tar.gz 
    chmod +x ./dist/proot
    rm -rf ptero-vm.zip
    rm -rf root.zip
    rm -rf root.tar.gz
    touch installed
    ./dist/proot -S . /bin/bash -c "mv apth /usr/bin/"
    ./dist/proot -S . /bin/bash -c "mv unzip /usr/bin/"
    ./dist/proot -S . /bin/bash -c "apt-get update"
    ./dist/proot -S . /bin/bash -c "apt-get -y upgrade"
    ./dist/proot -S . /bin/bash -c "apt-get -y install curl"
    ./dist/proot -S . /bin/bash -c "apt-get -y install wget"
    ./dist/proot -S . /bin/bash -c "apt-get -y install neofetch"
    ./dist/proot -S . /bin/bash -c "curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py"
    ./dist/proot -S . /bin/bash -c "chmod +x /bin/systemctl"
    echo "Starting PteroVM"
    ./dist/proot -S . /bin/bash --login
fi
