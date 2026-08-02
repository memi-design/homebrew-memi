# Homebrew formula template for Mémoire
#
# This file is a TEMPLATE. CI fills in 2.7.7 and @SHA_*@ placeholders on
# every release and pushes the result to the homebrew-memi tap repo.
# Users install with:  brew install memi-design/memi/memoire
#
class Memoire < Formula
  desc "Registry-first CLI for publishing Figma design systems as installable packages"
  homepage "https://memoire.cv"
  version "2.7.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/memi-design/memi/releases/download/v2.7.7/memi-darwin-arm64.tar.gz"
      sha256 "db73a359939c66dd4cb3efacdadfb1dd6fa134cda6abff9e808240a548067020"
    end
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.7.7/memi-darwin-x64.tar.gz"
      sha256 "9364ff669fffe13f1dcaa26aee974ec4ff8fff103621d419e4e81d2d97810d52"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/memi-design/memi/releases/download/v2.7.7/memi-linux-x64.tar.gz"
      sha256 "6043a23d9af60d9c1da7859b1c830d74a01fe8e8313b943921f048d67098114b"
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
