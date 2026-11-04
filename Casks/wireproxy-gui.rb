cask "wireproxy-gui" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.3.2"
  sha256 arm:   "fcaaa2062664dfc1bfda6ad7b532407562a2e7a94baca8f8500ce1f7ab3b284d",
         intel: "4b9c196063010e2fd8c273f54cc9f5222f34f5448ed53d98b15312b1b96dd157"

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
