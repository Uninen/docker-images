#!/bin/bash
set -euo pipefail

apt update 
apt -y upgrade
ls /root/
/root/scripts/install-common.sh

/root/scripts/cleanup.sh
