#!/bin/bash
set -ev

# Configure and build release
pushd build
cmake ../${EXAMPLE}/ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install/
make
make install
make dmg
popd

# Test execution
# pushd install
# ${EXAMPLE}.app/Contents/MacOS/${EXAMPLE} test
# popd
