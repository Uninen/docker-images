#!/bin/bash
set -euo pipefail

apt-get autoremove --purge -y -o APT::AutoRemove::RecommendsImportant=false
apt-get clean

rm -rf /var/cache/apt/* /var/lib/apt/lists/* /root/.cache
