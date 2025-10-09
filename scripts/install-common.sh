#!/bin/bash
set -euo pipefail

apt update
apt install -y gpg apt-transport-https ca-certificates

apt update
apt -y upgrade 
apt -y install --no-install-recommends git nano curl wget gnupg2 ssh
