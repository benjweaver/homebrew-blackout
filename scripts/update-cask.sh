#!/usr/bin/env bash
# Points Casks/blackout.rb at the latest Blackout release, or at the tag given as
# the first argument.
set -euo pipefail
cd "$(dirname "$0")/.."

tag=${1:-$(gh release view --repo benjweaver/blackout --json tagName --jq .tagName)}
version=${tag#v}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
gh release download "$tag" --repo benjweaver/blackout --pattern "Blackout-$version.zip" --dir "$tmp"
sha=$(shasum -a 256 "$tmp/Blackout-$version.zip" | cut -d' ' -f1)
sed -i.bak -e "s/^  version \".*\"/  version \"$version\"/" -e "s/^  sha256 \".*\"/  sha256 \"$sha\"/" Casks/blackout.rb
rm Casks/blackout.rb.bak
echo "blackout $version $sha"
