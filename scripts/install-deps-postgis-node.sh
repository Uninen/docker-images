#!/bin/bash
set -euo pipefail

apt update 
apt -y upgrade 
apt -y install --no-install-recommends apt-utils build-essential libpq-dev binutils libproj-dev gdal-bin curl ca-certificates dirmngr software-properties-common gnupg gnupg2 apt-transport-https wget ffmpeg
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt update 
apt-get install -y nodejs postgresql-client
./install-audiowaveform.sh
npm install --global pnpm
pip install --upgrade pip --no-cache-dir
pip install pip-tools playwright
playwright install --with-deps firefox
apt-get remove -y build-essential git make cmake gcc g++
apt-get remove -qq --allow-remove-essential --purge -y -qq
apt-get autoremove -y
apt-get clean -y
rm -rf /var/cache/apt/*
rm -rf /var/lib/apt/lists/*
rm -rf /root/.cache
