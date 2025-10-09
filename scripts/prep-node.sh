#!/bin/bash
set -euo pipefail

apt update 
apt -y upgrade

/root/scripts/install-common.sh

/root/scripts/cleanup.sh
