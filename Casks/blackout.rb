cask "blackout" do
  version "0.1.0"
  sha256 "c4651c997cec4eb5854074fc055004d2c7d1c512c9ae68c9985862f313715616"

  url "https://github.com/benjweaver/blackout/releases/download/v#{version}/Blackout-#{version}.zip"
  name "Blackout"
  desc "Hides the MacBook notch by blacking out the menu bar"
  homepage "https://github.com/benjweaver/blackout"

  depends_on macos: ">= :sonoma"

  app "Blackout.app"

  # Blackout is not notarized yet, so clear the quarantine flag or Gatekeeper refuses to open it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Blackout.app"]
  end

  zap trash: "~/Library/Preferences/dev.benjweaver.Blackout.plist"
end
