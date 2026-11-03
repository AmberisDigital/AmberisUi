require "test_helper"

class StylesheetsTest < Minitest::Test
  include SassHelper

  def test_defaults_compile_without_contrast_warnings
    css, warnings = compile

    assert_includes css, "--primary: #9C5D0D"
    assert_includes css, "--accent: #C77C1E"
    assert_empty warnings
  end

  def test_brand_colour_reaches_bootstrap_and_tokens
    css, = compile("$brand-primary: #0B6E4F; $brand-accent: #0E9F6E;")

    assert_includes css, "--primary: #0B6E4F"
    assert_includes css, "--bs-primary: #0B6E4F"
    assert_includes css, "--accent: #0E9F6E"
  end

  def test_dark_mode_derives_from_the_accent
    css, = compile("$brand-accent: #0E9F6E;")
    dark = css[/\[data-bs-theme=dark\]\s*\{[^}]*--primary:[^}]*\}/]

    refute_nil dark
    refute_includes dark, "--primary: #D9"   # not Care's amber any more
  end

  def test_warns_when_white_on_primary_is_too_weak
    _, warnings = compile("$brand-primary: #C77C1E;")

    assert warnings.any? { |w| w.include?("Weiß auf $brand-primary") }, warnings.inspect
  end

  def test_includes_tokens_base_and_components
    css, = compile

    ["--space-4: 16px", "--ui-height: 44px", ".btn-primary", ".card-stat",
     ".table-mobile-cards", ".sidebar .nav-link.active", ".ts-wrapper", ".toast-success",
     ".admin-notice", ".text-clamp"].each { |piece| assert_includes css, piece }
  end

  def test_heading_classes_follow_the_element_scale
    css, = compile
    last_h3 = css.scan(/^[^{}]*\.h3[^{}]*\{[^}]*font-size:\s*([^;]+);/).flatten.last

    assert_equal "1.15rem", last_h3
  end

  def test_app_specific_helpers_stay_out
    css, = compile

    refute_includes css, ".signature-pad"
    refute_includes css, ".bg-eigenaussage"
  end

  def test_app_cannot_override_bootstrap_colours_directly
    css, = compile("$primary: #ff0000;")

    refute_includes css, "--bs-primary: #ff0000"
  end
end
