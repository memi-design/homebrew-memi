# Homebrew formula template for Mémoire
#
# This file is a TEMPLATE. CI fills in 2.6.3 and @SHA_*@ placeholders on
# every release and pushes the result to the homebrew-memi tap repo.
# Users install with:  brew install memi-design/memi/memoire
#
class Memoire < Formula
  desc "Registry-first CLI for publishing Figma design systems as installable packages"
  homepage "https://memoire.cv"
  version "2.6.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/memi-design/memi/releases/download/v2.6.3/memi-darwin-arm64.tar.gz"
      sha256 "6bdd9875a384245a06fa82b65c6fe0f63b485d7a65396304cafbcf6f7d59d1e2"
    end
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.6.3/memi-darwin-x64.tar.gz"
      sha256 "5c9d8cd1edd919b208de16cb2a9832e94d87ffa821e8d84e2dfb7c21d9f3863b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.6.3/memi-linux-x64.tar.gz"
      sha256 "924867f957a75f2c7768205e518d753489fa8c46d213e6f8dc7b1494238eeeb0"
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
