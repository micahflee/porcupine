#!/bin/bash
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
cd $ROOT

VERSION=`cat $ROOT/share/version`
VERSION=${VERSION:1}

# Deleting old build folders folders
echo Deleting old build folders folders
rm -rf $ROOT/build $ROOT/dist &>/dev/null 2>&1

# Build the .app
echo Building Porcupine.app
pyinstaller install/pyinstaller.spec
sed 's/{{VERSION}}/'"$VERSION"'/g' install/Info.plist > dist/Porcupine.app/Contents/Info.plist

if [ "$1" = "--release" ]; then
  mkdir -p dist
  APP_PATH="dist/Porcupine.app"
  PKG_PATH="dist/Porcupine.pkg"
  IDENTITY_NAME_APPLICATION="Developer ID Application: Micah Lee"
  IDENTITY_NAME_INSTALLER="Developer ID Installer: Micah Lee"

  echo "Codesigning the app bundle"
  codesign --deep -s "$IDENTITY_NAME_APPLICATION" "$APP_PATH"

  echo "Creating an installer"
  productbuild --sign "$IDENTITY_NAME_INSTALLER" --component "$APP_PATH" /Applications "$PKG_PATH"

  echo "Cleaning up"
  rm -rf "$APP_PATH"

  echo "All done, your installer is in: $PKG_PATH"
fi
