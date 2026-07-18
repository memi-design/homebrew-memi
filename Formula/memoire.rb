# Homebrew formula template for Mémoire
#
# This file is a TEMPLATE. CI fills in 2.6.1 and @SHA_*@ placeholders on
# every release and pushes the result to the homebrew-memi tap repo.
# Users install with:  brew install sarveshsea/memi/memoire
#
class Memoire < Formula
  desc "Registry-first CLI for publishing Figma design systems as installable packages"
  homepage "https://memoire.cv"
  version "2.6.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/sarveshsea/memi/releases/download/v2.6.1/memi-darwin-arm64.tar.gz"
      sha256 "37bcad3a6475168fecc4b4f202bdba3839350aca3b475fcd0da3f18f03385362"
    end
    on_intel do
      url "https://github.com/sarveshsea/memi/releases/download/v2.6.1/memi-darwin-x64.tar.gz"
      sha256 "e3128a07a881bf7dc4bbd11a0662a9734b149017fb1d6d413ecb625793c64d61"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/sarveshsea/memi/releases/download/v2.6.1/memi-linux-x64.tar.gz"
      sha256 "a0d0e27a22abfa5762ede4f7dd205a71e38efc75fd9e1f635951071891b83166"
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
