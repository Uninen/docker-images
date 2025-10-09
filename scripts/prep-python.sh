#!/bin/bash
set -euo pipefail

/root/scripts/install-common.sh

apt-get -y install --no-install-recommends curl apt-utils

/root/scripts/install-postgres-client.sh

/root/scripts/cleanup.sh
