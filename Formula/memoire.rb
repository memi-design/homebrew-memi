# Homebrew formula template for Mémoire
#
# This file is a TEMPLATE. CI fills in 2.7.4 and @SHA_*@ placeholders on
# every release and pushes the result to the homebrew-memi tap repo.
# Users install with:  brew install memi-design/memi/memoire
#
class Memoire < Formula
  desc "Registry-first CLI for publishing Figma design systems as installable packages"
  homepage "https://memoire.cv"
  version "2.7.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/memi-design/memi/releases/download/v2.7.4/memi-darwin-arm64.tar.gz"
      sha256 "72e7135e6c0b1236b8b9a2dcae68b6ac732f208d975be5d11da4491ac7a3f1c8"
    end
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.7.4/memi-darwin-x64.tar.gz"
      sha256 "39cc1d5661c1af5752da4cf8e7de39701ab15fceaf80a88b8d52d5c8486156a3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.7.4/memi-linux-x64.tar.gz"
      sha256 "a78e4df6576c2aeb1403887476fc365845038919a1fc7ef00af9f7b43da1ace6"
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
