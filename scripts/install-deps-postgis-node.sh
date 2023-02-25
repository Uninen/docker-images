#!/bin/bash
set -euo pipefail

apt update 
apt -y upgrade 
apt -y install --no-install-recommends apt-utils build-essential libpq-dev binutils libproj-dev gdal-bin curl ca-certificates postgresql-client
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs
npm install --global pnpm
pip install --upgrade pip --no-cache-dir
pip install pip-tools
apt-get remove -qq --allow-remove-essential --purge -y -qq
apt-get autoremove -y
apt-get clean -y
rm -rf /var/cache/apt/*
rm -rf /var/lib/apt/lists/*
rm -rf /root/.cache
