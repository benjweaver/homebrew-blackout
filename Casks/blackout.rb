cask "blackout" do
  version "1.0.0"
  sha256 "8bc79d00193edc195babfd36c087f6918690391f6b239e117786e390079bf82c"

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
