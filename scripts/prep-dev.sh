#!/bin/bash
set -euo pipefail

/root/scripts/install-common.sh

apt install -y --no-install-recommends build-essential pkg-config ffmpeg libpixman-1-dev libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev seahorse gcc libc6

/root/scripts/install-postgres-client.sh
/root/scripts/install-node.sh
/root/scripts/install-audiowaveform.sh
/root/scripts/install-node.sh
/root/scripts/install-rust.sh

corepack enable
corepack prepare pnpm@latest-10 --activate

# Intentional: no cleanup for dev image