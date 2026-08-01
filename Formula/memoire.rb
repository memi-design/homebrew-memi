# Homebrew formula template for Mémoire
#
# This file is a TEMPLATE. CI fills in 2.7.3 and @SHA_*@ placeholders on
# every release and pushes the result to the homebrew-memi tap repo.
# Users install with:  brew install memi-design/memi/memoire
#
class Memoire < Formula
  desc "Registry-first CLI for publishing Figma design systems as installable packages"
  homepage "https://memoire.cv"
  version "2.7.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/memi-design/memi/releases/download/v2.7.3/memi-darwin-arm64.tar.gz"
      sha256 "fa4b50ed071c485b8b879149fbcf89b55601f8f564ffa26b08ff461f3a1ec120"
    end
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.7.3/memi-darwin-x64.tar.gz"
      sha256 "1d93f0b72f9045012e2ec62ab67150ff847314b152a712eb223e65a24f6d97c8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.7.3/memi-linux-x64.tar.gz"
      sha256 "1006e942120360fcede9a3dde3fe3112cda2325f17ce39990c8464bf5b42d1d6"
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
