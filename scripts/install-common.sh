#!/bin/bash
set -euo pipefail

apt-get update
apt-get -y upgrade
apt-get -y install --no-install-recommends ca-certificates git nano curl wget openssh-client build-essential
