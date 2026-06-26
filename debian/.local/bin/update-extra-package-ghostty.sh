#!/bin/bash

set -eu

TEMP_DIR="$(mktemp --directory)"

function clean_up() {
  rm --recursive --force "$TEMP_DIR"
}

trap clean_up EXIT
cd "$TEMP_DIR"

GH_REPO="dariogriffo/ghostty-debian"

LATEST_TAG_NAME="$(gh release --repo "$GH_REPO" list --json tagName,isLatest | jq --raw-output 'map( select( .isLatest == true ) ) | .[0].tagName')"

OS_CODENAME="$(lsb_release --codename --short)"
LATEST_VERSION="$(echo "$LATEST_TAG_NAME" | tr '+' '-')+$OS_CODENAME"
INSTALLED_VERSION="$(dpkg-query --showformat='${Version}' --show ghostty || echo "UNINSTALLED")"

[[ "$LATEST_VERSION" = "$INSTALLED_VERSION" ]] && echo "ghostty is already up-to-date." && exit 0

echo "ghostty needs to be updated..."
gh release --repo "$GH_REPO" download "$LATEST_TAG_NAME"

KERNEL_RELEASE="$(uname --kernel-release)"
ARCH="${KERNEL_RELEASE##*-}"

sudo apt install --fix-broken "./ghostty_${LATEST_VERSION}_$ARCH.deb"
