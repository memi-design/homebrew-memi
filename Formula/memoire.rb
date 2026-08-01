# Homebrew formula template for Mémoire
#
# This file is a TEMPLATE. CI fills in 2.7.1 and @SHA_*@ placeholders on
# every release and pushes the result to the homebrew-memi tap repo.
# Users install with:  brew install memi-design/memi/memoire
#
class Memoire < Formula
  desc "Registry-first CLI for publishing Figma design systems as installable packages"
  homepage "https://memoire.cv"
  version "2.7.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/memi-design/memi/releases/download/v2.7.1/memi-darwin-arm64.tar.gz"
      sha256 "2aa9c2ec54f6b9bbd36cc9110b251c293c47619872c10e7b866f105f65857156"
    end
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.7.1/memi-darwin-x64.tar.gz"
      sha256 "7288152afb1d88fb129545fec6a020e29a8ec0e22c5cdb58a852ceedf21ec9a4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.7.1/memi-linux-x64.tar.gz"
      sha256 "de736a28bae2f917185da00bfa44bc86333a6d18f693f510c38ed3ea649048f7"
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
