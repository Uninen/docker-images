#!/bin/bash
set -euo pipefail

apt update
apt -y upgrade
apt install -y --no-install-recommends build-essential pkg-config ffmpeg libpixman-1-dev libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev git ssh gpa seahorse
apt-get remove -qq --allow-remove-essential --purge -y -qq
apt-get autoremove -y
