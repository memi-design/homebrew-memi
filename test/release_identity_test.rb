# frozen_string_literal: true

require "digest"
require "json"
require "minitest/autorun"

class ReleaseIdentityTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)
  FORMULA = File.read(File.join(ROOT, "Formula", "memoire.rb"))
  README = File.read(File.join(ROOT, "README.md"))
  VERSION = "2.7.7"
  RELEASE_BASE = "https://github.com/memi-design/memi/releases/download/v#{VERSION}"
  EXPECTED_ASSETS = {
    "#{RELEASE_BASE}/memi-darwin-arm64.tar.gz" => "db73a359939c66dd4cb3efacdadfb1dd6fa134cda6abff9e808240a548067020",
    "#{RELEASE_BASE}/memi-darwin-x64.tar.gz" => "9364ff669fffe13f1dcaa26aee974ec4ff8fff103621d419e4e81d2d97810d52",
    "#{RELEASE_BASE}/memi-linux-x64.tar.gz" => "6043a23d9af60d9c1da7859b1c830d74a01fe8e8313b943921f048d67098114b",
  }.freeze
  BRAND_MANIFEST_SHA256 = "8b7ca68e836ee0362fe1763b067dacb8e500d5037cd12791f6c5aaf0e80a2755"
  BRAND_SCHEMA_SHA256 = "ef3eaed367e20c3d54ef8284d84c8195d40fb5916fcd525fcd77243a0353e473"

  def test_formula_describes_the_current_cli_and_organization_release_assets
    assert_includes FORMULA, 'desc "Read-only design engineering audits and skills for coding agents"'
    assert_includes FORMULA, 'homepage "https://www.memoire.cv"'
    assert_includes FORMULA, "https://github.com/memi-design/memi/releases/download/"
    refute_includes FORMULA, "github.com/sarveshsea"
  end

  def test_formula_binds_every_supported_platform_asset_to_release_checksums
    assert_match(/^  version "#{Regexp.escape(VERSION)}"$/, FORMULA)
    assert_equal EXPECTED_ASSETS, FORMULA.scan(/url "([^"]+)"\s+sha256 "([a-f0-9]{64})"/).to_h
    assert_includes FORMULA, '(bin/"memi").write_env_script libexec/"memi", {}'
    assert_includes FORMULA, 'assert_match version.to_s, shell_output("#{bin}/memi --version")'
  end

  def test_tap_readme_covers_cli_lifecycle_and_canonical_release_truth
    assert_includes README, "Read-only design engineering audits and skills for coding agents"
    assert_includes README, "brew upgrade memoire"
    assert_includes README, "brew uninstall memoire"
    assert_includes README, "https://github.com/memi-design/memi/releases/tag/v2.7.7"
    assert_includes README, "https://github.com/memi-design/memi/blob/main/docs/CURRENT_RELEASE.md"
  end

  def test_ci_runs_the_tap_contract_and_homebrew_validation
    workflow = File.read(File.join(ROOT, ".github", "workflows", "ci.yml"))

    assert_match(%r{uses: actions/checkout@[0-9a-f]{40}}, workflow)
    assert_includes workflow, "ruby test/release_identity_test.rb"
    assert_includes workflow, "ruby -c Formula/memoire.rb"
    assert_includes workflow, "brew style Formula/memoire.rb"
    assert_includes workflow, 'tap_root="$(brew --repository)/Library/Taps/memi-design/homebrew-memi"'
    assert_includes workflow, 'ln -s "$GITHUB_WORKSPACE" "$tap_root"'
    assert_includes workflow, "brew audit --formula --strict memi-design/memi/memoire"
    refute_includes workflow, "brew audit --formula --strict Formula/memoire.rb"
  end

  def test_tap_pins_revision_3_organization_brand_and_canvas_truth
    manifest_path = File.join(ROOT, "brand", "brand-manifest.v1.json")
    schema_path = File.join(ROOT, "brand", "brand-manifest.v1.schema.json")
    assert_equal BRAND_MANIFEST_SHA256, Digest::SHA256.file(manifest_path).hexdigest
    assert_equal BRAND_SCHEMA_SHA256, Digest::SHA256.file(schema_path).hexdigest

    manifest = JSON.parse(File.read(manifest_path))
    assert_equal 3, manifest.fetch("brandRevision")
    cli = manifest.fetch("products").find { |product| product.fetch("id") == "cli" }
    assert_equal "memi CLI", cli.fetch("name")
    assert_equal "available", cli.fetch("status")
    assert_equal "https://github.com/memi-design/memi", cli.dig("urls", "repository")
    assert_equal "https://www.npmjs.com/package/@memi-design/cli", cli.dig("urls", "package")
    assert_equal [{
      "name" => "@memi-design/cli",
      "registry" => "npm",
      "status" => "current",
      "url" => "https://www.npmjs.com/package/@memi-design/cli",
    }], cli.fetch("packages")
    assert_equal({
      "spdx" => "MIT",
      "name" => "MIT License",
      "url" => "https://github.com/memi-design/memi/blob/main/LICENSE",
    }, cli.fetch("license"))
    assert_includes FORMULA, %(#{cli.dig("urls", "repository")}/releases/download/)
    assert_includes FORMULA, %(license "#{cli.dig("license", "spdx")}")

    canvas = manifest.fetch("products").find { |product| product.fetch("id") == "canvas" }
    assert_equal "development", canvas.fetch("status")
    assert_equal "Open-source M0 development snapshot; not yet a production importer or source editor.", canvas.fetch("statusNote")
    assert_equal [{
      "id" => "canvas-single-heart",
      "purpose" => "app",
      "url" => "https://raw.githubusercontent.com/memi-design/memi-canvas/main/apps/macos/src-tauri/icons/icon.png",
      "sourceUrl" => "https://raw.githubusercontent.com/memi-design/memi-canvas/main/apps/macos/src-tauri/icons/source/MemiCanvas-Iteration-02.icon/icon.json",
      "sha256" => "da068f20ba9e0e43f59ebde8602b43342f8c77fef2c080155a18d5a8fd0e25c2",
      "alt" => "Ruby single pixel-heart memi Canvas icon",
    }], canvas.fetch("icons")
  end
end
