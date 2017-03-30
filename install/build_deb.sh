#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
cd $DIR

VERSION=`cat share/version`
VERSION=${VERSION:1}

# clean up from last build
rm -r deb_dist >/dev/null 2>&1

# build binary package
python3 setup.py --command-packages=stdeb.command bdist_deb

# return install instructions if build succeeds
if [[ $? -eq 0 ]]; then
    echo ""
    echo "To install, run:"
    echo "sudo dpkg -i deb_dist/porcupine_$VERSION-1_all.deb"
else
    echo ""
    echo "Porcupine failed to build!"
fi
