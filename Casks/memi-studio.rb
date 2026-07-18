cask "memi-studio" do
  version "2.5.0"

  on_arm do
    sha256 "7755216680a317d2b95e2926b5ff3181eb1f9ca798d428cfe5a47d3402a96f84"

    url "https://github.com/sarveshsea/memi-studio/releases/download/v#{version}/Memoire.Studio_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "58f5ec7b475199bda8343f840e703f95c32c8eecf01e315df6678c980407c5fd"

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
