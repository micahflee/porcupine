#!/usr/bin/env python3
import os
import sys
from setuptools import setup

version_file = os.path.join(os.path.dirname(__file__), 'share', 'version')
version = open(version_file).read().strip().lstrip('v')

description = ("Set porcupine as your default web browser. When you click a "
               "link, porcupine will copy the URL to your clipboard and "
               "notify you about this.")
long_description = ("{} Or it can run a command of your choice. This way "
                    "you'll never accidentally open a link you don't want to, "
                    "and you can easily choose which browser to load it "
                    "in.").format(description)

author = 'Micah Lee'
author_email = 'micah@micahflee.com'
url = 'https://github.com/micahflee/porcupine'
license = 'GPL v3'

setup(
    name='porcupine', version=version,
    description=description, long_description=long_description,
    author=author, author_email=author_email,
    url=url, license=license,
    scripts=['porcupine'],
    data_files=[
        (os.path.join(sys.prefix, 'share/applications'), ['share/porcupine.desktop']),
        (os.path.join(sys.prefix, 'share/pixmaps'), ['share/porcupine.png'])
    ]
)
