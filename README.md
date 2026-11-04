# homebrew-tap

Homebrew tap for NRngnl apps.

## wireproxy-gui

[Wireproxy GUI](https://github.com/NRngnl/wireproxy-gui), macOS Apple silicon and Intel.

```sh
brew install --cask NRngnl/tap/wireproxy-gui
```

Installs `Wireproxy GUI.app`. The app is ad-hoc signed and not notarized; the cask clears
the download quarantine so it opens normally.

The cask follows the latest GitHub release; `.github/workflows/bump.yml` checks every 6
hours, reads each zip's digest from its `.sha256` release asset, and waits while a release
has none yet. A new version lands as a pull request that the workflow merges itself
(`main` takes changes only through pull requests).
