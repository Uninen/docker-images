#!/bin/bash
set -euo pipefail

/root/scripts/install-common.sh

apt -y install --no-install-recommends apt-utils build-essential libpq-dev binutils libproj-dev gdal-bin dirmngr ffmpeg

/root/scripts/install-postgres-client.sh
/root/scripts/install-mysql.sh

/root/scripts/cleanup.sh
