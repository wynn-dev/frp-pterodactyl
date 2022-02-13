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
    echo "Downloading files FRP server"
    curl -sSLo frps https://github.com/wynn-dev/frp-pterodactyl/raw/main/bin/frps
    curl -sSLo config.ini https://raw.githubusercontent.com/wynn-dev/frp-pterodactyl/main/bin/config.ini
    echo "Installing FRP server"
    touch installed
    echo "Starting FRP server"
    ./frps -c ./config.ini
fi
