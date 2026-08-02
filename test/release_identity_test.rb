# frozen_string_literal: true

require "minitest/autorun"

class ReleaseIdentityTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)
  FORMULA = File.read(File.join(ROOT, "Formula", "memoire.rb"))
  README = File.read(File.join(ROOT, "README.md"))

  def test_formula_describes_the_current_cli_and_organization_release_assets
    assert_includes FORMULA, 'desc "Read-only design engineering audits and skills for coding agents"'
    assert_includes FORMULA, 'homepage "https://www.memoire.cv"'
    assert_includes FORMULA, "https://github.com/memi-design/memi/releases/download/"
    refute_includes FORMULA, "github.com/sarveshsea"
  end

  def test_tap_readme_covers_cli_lifecycle_and_canonical_release_truth
    assert_includes README, "Read-only design engineering audits and skills for coding agents"
    assert_includes README, "brew upgrade memoire"
    assert_includes README, "brew uninstall memoire"
    assert_includes README, "https://github.com/memi-design/memi/releases/tag/v2.7.7"
    assert_includes README, "https://github.com/memi-design/memi/blob/main/docs/CURRENT_RELEASE.md"
  end
end
