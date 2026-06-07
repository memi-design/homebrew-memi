cask "memi-studio" do
  version "1.0.4"

  on_arm do
    sha256 "cd1dc510dedfe4fc9735b6a48e32df4cc59d82a61d9cc4e327e243d1e832c8a6"

    url "https://github.com/sarveshsea/memi-studio/releases/download/v#{version}/Memoire.Studio_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "11364b2d218c0224046afdce10123189aab011ef6cd9296d32d068ce02814092"

    url "https://github.com/sarveshsea/memi-studio/releases/download/v#{version}/Memoire.Studio_#{version}_x64.dmg"
  end

  name "Mémoire Studio"
  desc "Agent shell for Codex and Claude Code"
  homepage "https://github.com/sarveshsea/memi-studio"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :big_sur

  app "Mémoire Studio.app"

  zap trash: [
    "~/Library/Application Support/cv.memoire.studio",
    "~/Library/Caches/cv.memoire.studio",
    "~/Library/HTTPStorages/cv.memoire.studio",
    "~/Library/Logs/cv.memoire.studio",
    "~/Library/Preferences/cv.memoire.studio.plist",
    "~/Library/Saved Application State/cv.memoire.studio.savedState",
    "~/Library/WebKit/cv.memoire.studio",
  ]
end
