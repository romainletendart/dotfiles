#!/bin/bash

set -eu

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

echo "Updating firmware..."
sudo -- fwupdmgr refresh --force && fwupdmgr update

echo ""
echo "Updating system packages..."
sudo -- bash -c "apt update && apt upgrade"

echo ""
echo "Updating manually installed debian packages..."
"$SCRIPT_DIR"/update-extra-package-ghostty.sh
"$SCRIPT_DIR"/update-extra-package-neovim.sh

echo ""
echo "Updating manually installed cargo packages"
# cargo install --list | grep --extended-regexp --only-matching '^[^ ]+' | xargs cargo install
cargo-install-update install-update --all
