# Homebrew formula template for Mémoire
#
# This file is a TEMPLATE. CI fills in 2.7.6 and @SHA_*@ placeholders on
# every release and pushes the result to the homebrew-memi tap repo.
# Users install with:  brew install memi-design/memi/memoire
#
class Memoire < Formula
  desc "Registry-first CLI for publishing Figma design systems as installable packages"
  homepage "https://memoire.cv"
  version "2.7.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/memi-design/memi/releases/download/v2.7.6/memi-darwin-arm64.tar.gz"
      sha256 "1a3d901e28f3300d87f7db73fcab6c99aabcc0c36165a2bfe148ab646a432ef8"
    end
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.7.6/memi-darwin-x64.tar.gz"
      sha256 "763bb0977de483eab0bc6bbc311c2f6828f81d8a022334721aa681151efaaa35"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.7.6/memi-linux-x64.tar.gz"
      sha256 "c6eaf2ad884d8d5f5757771d73d254df444af39b2e0bace83caf9389c054df4f"
    end
  end

  def install
    libexec.install Dir["*"]
    (bin/"memi").write_env_script libexec/"memi", {}
    (bin/"memoire").write_env_script libexec/"memi", {}
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/memi --version")
  end
end
