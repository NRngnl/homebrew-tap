cask "wireproxy-gui" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.4.2"
  sha256 arm:   "093f4e597c3d1f6747ea5770d01c934d406742e5ff1d15fa16c508d6a591f055",
         intel: "f17f5925a587f69fa566e9fa32061decbd46cf3eea82f2f6110ffe22a78416c7"

  url "https://github.com/NRngnl/wireproxy-gui/releases/download/v#{version}/wireproxy-gui_#{version}_darwin_#{arch}.app.zip"
  name "Wireproxy GUI"
  desc "WireGuard- and Tailscale-backed SOCKS5 proxies from a tray app"
  homepage "https://github.com/NRngnl/wireproxy-gui"

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
