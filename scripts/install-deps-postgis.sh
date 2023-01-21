#!/bin/bash
set -euo pipefail

apt update 
apt -y upgrade 
apt -y install --no-install-recommends apt-utils build-essential libpq-dev binutils libproj-dev gdal-bin curl ca-certificates dirmngr software-properties-common gnupg gnupg2 apt-transport-https wget
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
apt update 
apt -y install --no-install-recommends postgresql-client
pip install --upgrade pip --no-cache-dir
pip install pip-tools
apt-get remove -qq --allow-remove-essential --purge -y -qq
apt-get autoremove -y
apt-get clean -y
rm -rf /var/lib/apt/lists/*
rm -rf /root/.cache
