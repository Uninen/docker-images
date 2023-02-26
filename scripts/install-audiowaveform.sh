#!/bin/bash
set -euo pipefail

apt update 
apt -y upgrade 
apt-get install -y build-essential git make cmake gcc g++ libmad0-dev libid3tag0-dev libsndfile1-dev libgd-dev \
    libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev 

git clone https://github.com/bbc/audiowaveform.git
cd audiowaveform

mkdir build
cd build
cmake -D ENABLE_TESTS=0 ..
make
make install
