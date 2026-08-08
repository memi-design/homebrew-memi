# Homebrew formula template for Mémoire
#
# This file is a TEMPLATE. CI fills in 2.7.9 and @SHA_*@ placeholders on
# every release and pushes the result to the homebrew-memi tap repo.
# Users install with:  brew install memi-design/memi/memoire
#
class Memoire < Formula
  desc "Registry-first CLI for publishing Figma design systems as installable packages"
  homepage "https://memoire.cv"
  version "2.7.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/memi-design/memi/releases/download/v2.7.9/memi-darwin-arm64.tar.gz"
      sha256 "b80ac81dc62071e9f07f31b96613ab7201b3a2109ed24a3235cb75e5be85002f"
    end
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.7.9/memi-darwin-x64.tar.gz"
      sha256 "d03ed015ce1d14c65c05e416ef99915a2faa15d4afe7269ed9f8fdc43612cae4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.7.9/memi-linux-x64.tar.gz"
      sha256 "80f31125919f6ed986de08db9fb72e0c6f12a03a7f3dc11002fec3493fe98b1c"
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
