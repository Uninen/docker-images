#!/bin/bash
set -euo pipefail

apt update 
apt -y upgrade 
/root/scripts/install-common.sh

apt -y install --no-install-recommends apt-utils build-essential libpq-dev binutils libproj-dev gdal-bin dirmngr software-properties-common

/root/scripts/install-postgres-client.sh
/root/scripts/install-mysql.sh


/root/scripts/cleanup.sh
