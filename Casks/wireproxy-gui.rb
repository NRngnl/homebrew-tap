cask "wireproxy-gui" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.3.3"
  sha256 arm:   "4646153925bbbc1007c53895f5765d1a7f134f841c795d10dfa17ad96c45da1d",
         intel: "f5431a6052e706c78762833bfbe39eeb50fb1fc6633aa077df37b8b96f4421bb"

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
