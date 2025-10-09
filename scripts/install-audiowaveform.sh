#!/bin/bash
set -euo pipefail

AUDIOWAVEFORM_VERSION="1.10.2"
DEB_FILE="audiowaveform_${AUDIOWAVEFORM_VERSION}-1-13_amd64.deb"
DEB_URL="https://github.com/bbc/audiowaveform/releases/download/${AUDIOWAVEFORM_VERSION}/${DEB_FILE}"

wget -q "${DEB_URL}"
apt update
dpkg -i "${DEB_FILE}" || apt -f install -y

rm -f "${DEB_FILE}"
