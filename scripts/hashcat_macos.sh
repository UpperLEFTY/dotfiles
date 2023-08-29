#!/bin/bash

git clone https://github.com/hashcat/hashcat.git
mkdir -p hashcat/deps
git clone https://github.com/KhronosGroup/OpenCL-Headers.git hashcat/deps/OpenCL
cd hashcat/ && make install 
./hashcat --version
./hashcat -b -D 1,2
./example0.sh