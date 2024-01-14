#!/bin/bash
set -euo pipefail

apt-get remove -qq --allow-remove-essential --purge -y -qq
apt-get autoremove -y
apt-get clean -y
rm -rf /var/cache/apt/*
rm -rf /var/lib/apt/lists/*
rm -rf /root/.cache
