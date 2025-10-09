#!/bin/bash
set -euo pipefail

apt update 
apt -y upgrade 
/root/scripts/install-common.sh

apt -y install --no-install-recommends apt-utils build-essential gcc ffmpeg libpixman-1-dev libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev

/root/scripts/install-audiowaveform.sh
/root/scripts/install-postgres-client.sh

/root/scripts/cleanup.sh
