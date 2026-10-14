#!/bin/bash
set -euo pipefail

. /etc/os-release

install -d -m 0755 /usr/share/keyrings
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc \
    -o /usr/share/keyrings/postgresql.asc
chmod 0644 /usr/share/keyrings/postgresql.asc
printf 'deb [signed-by=/usr/share/keyrings/postgresql.asc] https://apt.postgresql.org/pub/repos/apt %s-pgdg main\n' \
    "$VERSION_CODENAME" > /etc/apt/sources.list.d/pgdg.list

apt-get update
apt-get -y install --no-install-recommends postgresql-client-18
