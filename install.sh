#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

sudo cp -r usr/* /usr/
xdg-settings set default-web-browser porcupine.desktop
