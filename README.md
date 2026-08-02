# homebrew-memi

Official Homebrew tap for the **[Memi CLI](https://github.com/memi-design/memi)** and **[Memi Studio](https://github.com/memi-design/memi-studio)**.

The CLI provides **Read-only design engineering audits and skills for coding agents**. Studio is its optional supervised macOS companion.

## Install

```bash
brew install memi-design/memi/memoire
brew install --cask memi-design/memi/memi-studio
```

That's it. Brew adds the tap implicitly the first time you reference its formula or cask.

If you prefer to add the tap explicitly first:

```bash
brew tap memi-design/memi
brew install --cask memi-studio
```

## Update

```bash
brew upgrade memoire
brew upgrade --cask memi-studio
```

The formula follows immutable CLI assets from [Memi releases](https://github.com/memi-design/memi/releases). The cask carries `livecheck` against the [Studio releases](https://github.com/memi-design/memi-studio/releases) page, so `brew upgrade` picks up new stable versions once each tap entry is bumped.

## Uninstall

```bash
brew uninstall memoire
brew uninstall --cask memi-studio
brew uninstall --zap --cask memi-studio   # also clears Application Support, caches, prefs
```

## What you get

- **Universal install path** — `brew` resolves the right architecture automatically (Apple Silicon arm64 / Intel x64)
- **Memi CLI** — the `memi` command plus the compatibility `memoire` binary alias, installed from the organization-owned release
- **Signed + notarized DMG** — Mémoire Studio is signed by Humyn LLC (Team ID `Z4ZUZ884U3`) and Apple-notarized. Gatekeeper accepts the app at install with no warnings
- **Auto-update aware** — the cask declares `auto_updates true` so Homebrew defers to the app's in-app updater (Tauri updater) for minor releases between cask bumps
- **Clean uninstall** — the `zap` block lists every Application Support / Caches / Prefs path the app touches

## What this tap is

A standard Homebrew third-party tap. The CLI formula lives at [`Formula/memoire.rb`](./Formula/memoire.rb), and the app cask lives at [`Casks/memi-studio.rb`](./Casks/memi-studio.rb). Both use assets from organization-owned GitHub repositories.

## Maintenance

The engine release workflow renders the formula from its checked-in template and release checksums. The Studio cask is bumped separately after a signed and notarized Studio release.

## Related

- App source: [memi-design/memi-studio](https://github.com/memi-design/memi-studio)
- Engine and CLI: [memi-design/memi](https://github.com/memi-design/memi)
- CLI 2.7.7 release: [memi-design/memi v2.7.7](https://github.com/memi-design/memi/releases/tag/v2.7.7)
- Current release truth: [Memi current versions](https://github.com/memi-design/memi/blob/main/docs/CURRENT_RELEASE.md)
- Releases (DMGs + checksums): [memi-design/memi-studio/releases](https://github.com/memi-design/memi-studio/releases)

## License

This tap repository: MIT.
The Memi Studio app itself: [FSL-1.1-ALv2](https://github.com/memi-design/memi-studio/blob/main/LICENSE) (Humyn LLC).
