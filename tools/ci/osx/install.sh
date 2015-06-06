#!/bin/bash
set -ev

# Install from homebrew
brew outdated cmake || brew upgrade cmake
brew install qt5 p7zip

# Install other dependencies
pushd dependencies

# Install VLC-Qt prepared for examples
mkdir vlc-qt
pushd vlc-qt
curl -LO "https://googledrive.com/host/0B7I7Zg8w-HxRfmxSMmdhM3dTMGJnSklRX1c4ZkxmekJkcFplYnRLTU80R3Znd1VITkNueGs/vlc-qt_osx_examples.7z"
7z x vlc-qt_osx_examples.7z > /dev/null
popd

export PATH=$PWD/vlc-qt/bin/:/usr/local/opt/qt5/bin:$PATH

popd
