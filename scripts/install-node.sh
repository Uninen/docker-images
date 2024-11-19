#!/bin/bash
set -euo pipefail

curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt update 
apt -y install --no-install-recommends nodejs
