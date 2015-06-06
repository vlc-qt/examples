#!/bin/bash
set -ev

# Configure and build with Qt5
pushd build
cmake ../${EXAMPLE} -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install/
make
make install
popd

# Prepare for deployment
pushd install
tar -jcf ${EXAMPLE}.tar.bz2 *
popd
