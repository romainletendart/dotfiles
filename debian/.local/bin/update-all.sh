#!/bin/bash

set -eu

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

echo "Updating firmware..."
sudo -- fwupdmgr refresh --force && fwupdmgr update

echo "Updating system packages..."
sudo -- bash -c "apt update && apt upgrade"

echo "Updating manually installed system packages..."
"$SCRIPT_DIR"/update-extra-package-ghostty.sh
"$SCRIPT_DIR"/update-extra-package-neovim.sh
