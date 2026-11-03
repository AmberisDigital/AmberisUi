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

  def test_app_cannot_override_bootstrap_colours_directly
    css, = compile("$primary: #ff0000;")

    refute_includes css, "--bs-primary: #ff0000"
  end
end
