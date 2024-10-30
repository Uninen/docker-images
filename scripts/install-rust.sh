#!/bin/bash
set -euo pipefail

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

chmod -R 777 /usr/local/cargo
chmod -R 777 /usr/local/rustup
