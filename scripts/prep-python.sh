#!/bin/bash
set -euo pipefail

/root/scripts/install-common.sh

apt-get -y install --no-install-recommends apt-utils build-essential libpq-dev gcc software-properties-common

/root/scripts/install-postgres-client.sh

pip install --upgrade pip --no-cache-dir
pip install pip-tools

/root/scripts/cleanup.sh
