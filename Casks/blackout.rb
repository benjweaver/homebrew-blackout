cask "blackout" do
  version "0.1.1"
  sha256 "5b79fd7c40b832392efeb9f50baa296ab3ce785f16f682d2082bfaf37691afa6"

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

  zap trash: "~/Library/Preferences/dev.benjweaver.Blackout.plist"
end
