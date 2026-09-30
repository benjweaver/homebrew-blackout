# Homebrew tap for Blackout

[Blackout](https://github.com/benjweaver/blackout) hides the MacBook notch by blacking
out the menu bar. It's free, open source, and has no telemetry.

```sh
brew install --cask benjweaver/blackout/blackout
```

Blackout isn't notarized yet, so the cask clears the download quarantine flag after
installing; without that, macOS refuses to open it. Open Blackout from Applications to
change its settings, including whether it shows a menu bar icon.

`scripts/update-cask.sh` points `Casks/blackout.rb` at a release, the latest by default.
Blackout's release script runs it and pushes the result here, which starts the install test.
