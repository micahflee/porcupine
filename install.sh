#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

# Clean up
rm /usr/bin/porcipine /usr/share/applications/porcupine.desktop /usr/share/pixmaps/porcupine.png /var/lib/oz/cells.d/porcupine.json /var/lib/oz/cells.d/porcupine-whitelist.seccomp

if [ "$1" = "--subgraph" ]; then
    # In Subgraph OS, install app and oz profile
    sudo cp -r usr/* /usr/
    mv /usr/bin/porcipine /usr/bin-oz/porcupine
    ln -s /usr/bin/oz /usr/bin/porcupine
    sudo cp -r var/* /var/

    systemctl restart oz-daemon.service
else
    # Not in Subgraph OS, just install app
    sudo cp -r usr/* /usr/
fi

# Set porcupine as the default browser
xdg-settings set default-web-browser porcupine.desktop
