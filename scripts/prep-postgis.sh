#!/bin/bash
set -euo pipefail

apt update 
apt -y upgrade 
/root/scripts/install-common.sh

apt -y install --no-install-recommends apt-utils build-essential libpq-dev binutils libproj-dev gdal-bin ca-certificates dirmngr software-properties-common apt-transport-https

/root/scripts/install-postgres-client.sh

pip install --upgrade pip --no-cache-dir
pip install pip-tools

/root/scripts/cleanup.sh
