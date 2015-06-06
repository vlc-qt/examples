#!/bin/bash
set -ev

# Deploy builds
pushd install
curl --ftp-create-dirs -m 250 --retry 3 -T ${EXAMPLE}.dmg -u $FTP_USER:$FTP_PASSWORD ftp://ftp.tano.si/vlc-qt-examples/ci/${EXAMPLE}/osx/${EXAMPLE}_build${TRAVIS_BUILD_NUMBER}_${TRAVIS_COMMIT:0:7}.dmg
popd
