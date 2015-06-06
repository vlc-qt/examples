#!/bin/bash
set -ev

# Deploy builds
pushd install
curl --ftp-create-dirs -m 250 --retry 3 -T ${EXAMPLE}.tar.bz2 -u $FTP_USER:$FTP_PASSWORD ftp://ftp.tano.si/vlc-qt-examples/ci/${EXAMPLE}/linux/${EXAMPLE}_build${TRAVIS_BUILD_NUMBER}_${TRAVIS_COMMIT:0:7}_qt5.tar.bz2
popd
