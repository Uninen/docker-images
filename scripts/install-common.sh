#!/bin/bash
set -euo pipefail

apt-get update
apt-get install -y gpg apt-transport-https ca-certificates
apt-get clean
rm -rf /var/lib/apt/lists/*
apt-get update

apt-get -y install --no-install-recommends git nano curl wget gnupg2 ssh