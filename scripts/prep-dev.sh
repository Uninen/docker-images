#!/bin/bash
set -euo pipefail

apt update
apt -y upgrade
# The image is based on postgis-node image so no need to install common packages

apt install -y --no-install-recommends build-essential pkg-config ffmpeg libpixman-1-dev libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev gpa seahorse gcc

# Intentional: no cleanup for dev image