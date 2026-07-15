cask "memi-studio" do
  version "2.4.0"

  on_arm do
    sha256 "b99cd6935d86fa23b3049574c5a832a8c826931e5cb7647bad64de6c449af541"

    url "https://github.com/sarveshsea/memi-studio/releases/download/v#{version}/Memoire.Studio_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "77957f4c92886ec6a93e965265b6ae52d76ee8e38ed01d8bf14c5e92de1e413a"

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
