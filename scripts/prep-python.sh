#!/bin/bash
set -euo pipefail

/root/scripts/install-common.sh

apt-get -y install --no-install-recommends curl apt-utils build-essential libpq-dev gcc software-properties-common

/root/scripts/install-postgres-client.sh

/root/scripts/install-rust.sh

pip install --upgrade pip --no-cache-dir


/root/scripts/cleanup.sh
