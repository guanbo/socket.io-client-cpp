#!/bin/bash

set -e 

rm -rf build
mkdir -p build/install && cd build

cmake -DBOOST_ROOT:STRING=~/.local -DCMAKE_INSTALL_PREFIX=$(pwd)/install ..
cmake --build .
cmake --build . --target install