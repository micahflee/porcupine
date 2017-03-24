#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Clean up
rm /usr/bin/porcupine                           &>/dev/null 2>&1
rm /usr/share/applications/porcupine.desktop    &>/dev/null 2>&1
rm /usr/share/pixmaps/porcupine.png             &>/dev/null 2>&1

# Copy files
cp $ROOT/porcupine /usr/bin/
cp $ROOT/share/applications/porcupine.desktop /usr/share/applications/
cp $ROOT/share/pixmaps/porcupine.png /usr/share/pixmaps/

if [ "$1" = "--subgraph" ]; then
    # Clean up
    rm /var/lib/oz/cells.d/porcupine.json               &>/dev/null 2>&1
    rm /var/lib/oz/cells.d/porcupine-whitelist.seccomp  &>/dev/null 2>&1

    # Copy files
    cp $ROOT/subgraph/porcupine.json /var/lib/oz/cells.d/
    cp $ROOT/subgraph/porcupine-whitelist.seccomp /var/lib/oz/cells.d/

    # Set up oz profile
    mv /usr/bin/porcupine /usr/bin-oz/
    ln -s /usr/bin/oz /usr/bin/porcupine
    systemctl restart oz-daemon.service
fi

