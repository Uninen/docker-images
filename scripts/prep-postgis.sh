#!/bin/bash
set -euo pipefail

/root/scripts/install-common.sh

apt -y install --no-install-recommends apt-utils build-essential libpq-dev binutils libproj-dev gdal-bin dirmngr

/root/scripts/install-postgres-client.sh

pip install --upgrade pip --no-cache-dir
pip install pip-tools

/root/scripts/cleanup.sh
