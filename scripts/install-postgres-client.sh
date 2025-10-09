#!/bin/bash
set -euo pipefail

apt update 
apt install -y postgresql-common
sh /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y

apt -y install --no-install-recommends postgresql-client-17
