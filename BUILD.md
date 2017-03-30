# Building porcupine

Start by getting the source code:

```sh
git clone https://github.com/micahflee/porcupine.git
cd porcupine
```

## Linux

Install the needed dependencies:

For Debian-like distros: `apt install -y build-essential fakeroot python3-all python3-stdeb dh-python python3-pyqt5`

For Fedora-like distros: `dnf install -y rpm-build python3-qt5`

You can run porcupine without installing it:

```sh
./porcupine
./porcupine http://www.example.com
```

You can also build porcupine packages to install:

Create a .deb on Debian-like distros: `./install/build_deb.sh`

Create a .rpm on Fedora-like distros: `./install/build_rpm.sh`

# macOS and Windows

Probably coming soon...
