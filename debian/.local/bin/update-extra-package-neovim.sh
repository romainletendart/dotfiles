#!/bin/bash

set -eu

TEMP_DIR="$(mktemp --directory)"

function clean_up() {
  rm --recursive --force "$TEMP_DIR"
}

trap clean_up EXIT
cd "$TEMP_DIR"

GH_REPO="neovim/neovim"
LATEST_TAG_NAME="$(gh release --repo "$GH_REPO" list --json tagName,isLatest | jq --raw-output 'map( select( .isLatest == true ) ) | .[0].tagName')"
LATEST_VERSION="${LATEST_TAG_NAME#v}"

INSTALLED_VERSION="$(dpkg-query --showformat='${Version}' --show neovim || echo "UNINSTALLED")"

[[ "$INSTALLED_VERSION" =~ "$LATEST_VERSION" ]] && echo "neovim is already up-to-date." && exit 0

echo "neovim needs to be updated..."
ARCH="$(uname --machine)"
PKG_BASE_NAME="nvim-linux"
PKG_ARCHIVE_NAME="$PKG_BASE_NAME-$ARCH.tar.gz"

curl -LO "https://github.com/$GH_REPO/releases/download/$LATEST_TAG_NAME/$PKG_ARCHIVE_NAME"

# Recreate the archive without the parent directory as we want bin, lib, share at the root-level.
tar --extract --file "$PKG_ARCHIVE_NAME"
rm "$PKG_ARCHIVE_NAME"
mkdir --parents usr/local
mv "$PKG_BASE_NAME-$ARCH"/* usr/local

tar --create --file "neovim.tar.gz" usr

# Generate our deb package
fakeroot alien --to-deb --description="heavily refactored vim fork" --version="$LATEST_VERSION" --verbose "neovim.tar.gz"

# Install it
sudo dpkg --install "neovim_$LATEST_VERSION"*.deb
