#!/bin/bash
set -euo pipefail

/root/scripts/install-common.sh

apt-get -y install --no-install-recommends libpq-dev libgdal36 libgeos-c1t64 libproj25

/root/scripts/install-postgres-client.sh

/root/scripts/cleanup.sh
