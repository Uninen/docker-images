#!/bin/bash
set -euo pipefail

apt update 
apt -y upgrade 
apt -y install --no-install-recommends build-essential libpq-dev
pip install --upgrade pip --no-cache-dir
apt-get remove -qq --allow-remove-essential --purge -y -qq
apt-get autoremove -y
apt-get clean -y
rm -rf /var/lib/apt/lists/*
rm -rf /root/.cache
