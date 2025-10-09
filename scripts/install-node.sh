#!/bin/bash
set -euo pipefail

curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
apt update 
apt -y install --no-install-recommends nodejs
