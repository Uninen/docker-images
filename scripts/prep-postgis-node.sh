#!/bin/bash
set -euo pipefail

apt update 
apt -y upgrade 
/root/scripts/install-common.sh

apt -y install --no-install-recommends apt-utils build-essential libpq-dev binutils libproj-dev gdal-bin ca-certificates dirmngr software-properties-common apt-transport-https ffmpeg

/root/scripts/install-postgres-client.sh
/root/scripts/install-node.sh
/root/scripts/install-audiowaveform.sh

corepack enable
corepack prepare pnpm@latest-8 --activate

pip install --upgrade pip --no-cache-dir
pip install playwright
playwright install --with-deps firefox

/root/scripts/cleanup.sh
