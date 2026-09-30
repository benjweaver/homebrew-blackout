cask "blackout" do
  version "1.0.1"
  sha256 "1d56178c96b2a46ba976b9c9f20bc1c00a8db3d43ffa35ad328f504288cf8831"

  url "https://github.com/benjweaver/blackout/releases/download/v#{version}/Blackout-#{version}.zip"
  name "Blackout"
  desc "Hides the MacBook notch by blacking out the menu bar"
  homepage "https://github.com/benjweaver/blackout"

  depends_on macos: :sonoma

  app "Blackout.app"

  # Blackout is not notarized yet, so clear the quarantine flag or Gatekeeper refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Blackout.app"]
  end

  # Stop the running copy on uninstall and upgrade. A signal rather than `quit:`,
  # which would ask for Automation access; Blackout has nothing to save.
  uninstall signal: [["TERM", "dev.benjweaver.Blackout"]]

  zap trash: "~/Library/Preferences/dev.benjweaver.Blackout.plist"
end
