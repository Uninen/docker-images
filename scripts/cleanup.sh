#!/bin/bash
set -euo pipefail

apt remove --allow-remove-essential --purge -y -qq
apt autoremove -y
apt clean -y
rm -rf /var/cache/apt/*
rm -rf /var/lib/apt/lists/*
rm -rf /root/.cache
