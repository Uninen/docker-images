#!/bin/bash
set -euo pipefail

apt update 
apt -y upgrade 
/root/scripts/install-common.sh

apt -y install --no-install-recommends apt-utils build-essential libpq-dev gcc software-properties-common ffmpeg libpixman-1-dev libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev

/root/scripts/install-audiowaveform.sh
/root/scripts/install-postgres-client.sh

pip install --upgrade pip --no-cache-dir
pip install pip-tools

/root/scripts/cleanup.sh
