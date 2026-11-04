#!/bin/sh
# Rewrites Casks/wireproxy-gui.rb for a release of NRngnl/wireproxy-gui (default: the latest).
# usage: scripts/bump.sh [vX.Y.Z]   needs gh, authenticated for the public repo.
set -eu
cd "$(dirname "$0")/.."
repo=NRngnl/wireproxy-gui
tag=${1:-$(gh release view -R "$repo" --json tagName -q .tagName 2>/dev/null || true)}
[ -n "$tag" ] || { echo "no release yet, nothing to bump"; exit 0; }
version=${tag#v}
# Each macOS zip ships with a .sha256 file. Until both are uploaded the release is still
# being built: wait for the next run instead of failing this one.
sha_for() {
  gh release download "$tag" -R "$repo" -p "wireproxy-gui_${version}_darwin_$1.app.zip.sha256" -O - 2>/dev/null |
    awk '{print $1}'
}
arm=$(sha_for aarch64) && intel=$(sha_for x86_64) && [ -n "$arm" ] && [ -n "$intel" ] || {
  echo "$tag has no macOS checksums yet, nothing to bump"; exit 0; }
cat > Casks/wireproxy-gui.rb <<RB
cask "wireproxy-gui" do
  arch arm: "aarch64", intel: "x86_64"

  version "$version"
  sha256 arm:   "$arm",
         intel: "$intel"

  url "https://github.com/$repo/releases/download/v#{version}/wireproxy-gui_#{version}_darwin_#{arch}.app.zip"
  name "Wireproxy GUI"
  desc "WireGuard- and Tailscale-backed SOCKS5 proxies from a tray app"
  homepage "https://github.com/$repo"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "Wireproxy GUI.app"

  # The app is ad-hoc signed, not notarized: clear the download quarantine so it opens.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Wireproxy GUI.app"]
  end

  zap trash: [
    "~/Library/Preferences/fyne/com.github.nrngnl.wireproxy-gui",
    "~/Library/Application Support/wireproxy-gui",
  ]
end
RB
echo "wireproxy-gui $tag arm=$arm intel=$intel"
