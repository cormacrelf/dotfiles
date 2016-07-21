#!/bin/sh
set -e
DOWNLOAD_URL="https://github.com/getantibody/antibody/releases/download"
test -z "$TMPDIR" && TMPDIR="$(mktemp -d)"

last_version() {
  curl -s https://raw.githubusercontent.com/getantibody/homebrew-antibody/master/antibody.rb |
    grep version |
    cut -f2 -d '"'
}

download() {
  version="$(last_version)" || true
  test -z "$version" && {
    echo "Unable to get antibody version."
    exit 1
  }
  echo "Downloading antibody $version for $(uname -s)_$(uname -m)..."
  rm -f /tmp/antibody.tar.gz
  curl -s -L -o /tmp/antibody.tar.gz \
    "$DOWNLOAD_URL/v$version/antibody_$(uname -s)_$(uname -m).tar.gz"
}

extract() {
  tar -xf /tmp/antibody.tar.gz -C "$TMPDIR"
}

download
extract || true
echo "Installing antibody to /usr/local/bin/antibody"
sudo mv -f "$TMPDIR"/antibody /usr/local/bin/antibody
