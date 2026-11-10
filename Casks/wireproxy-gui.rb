cask "wireproxy-gui" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.4.0"
  sha256 arm:   "a2dfecda136cf6dc3b44116829f09402c21863598c1691619c69fbf34c40d7c8",
         intel: "7069175b2e81768a81f71849e0fecba3dd660fa334ccbfd651972789fac47af9"

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
