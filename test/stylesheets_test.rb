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
     ".table-mobile-cards", ":is(.sidebar, .sidebar-nav) .nav-link.active", ".ts-wrapper", ".toast-success",
     ".admin-notice", ".text-clamp"].each { |piece| assert_includes css, piece }
  end

  def test_dm_sans_is_served_from_the_gem
    css, = compile
    fonts = File.expand_path("../app/assets/fonts", __dir__)
    urls = css.scan(/url\("([^"]+\.woff2)"\)/).flatten

    assert_equal 4, urls.size
    urls.each { |url| assert File.exist?(File.join(fonts, url)), "missing #{url}" }
    assert_includes css, "font-weight: 100 1000"
    refute_includes css, "fonts.googleapis.com"
  end

  def test_menu_entries_look_the_same_in_the_offcanvas
    css, = compile

    assert_match(/:is\(\.sidebar, \.sidebar-nav\) \.nav-link\.active \{[^}]*background: var\(--primary-soft\)/, css)
    refute_match(/^\.sidebar \.nav-link/, css)
  end

  def test_page_title_is_22px_also_as_heading_class
    css, = compile

    assert_match(/h1, \.h1 \{\s*font-size: 1\.375rem;/, css)
  end

  def test_cool_palette_changes_neutrals_and_shadows
    css, warnings = compile("$neutral-palette: cool; $brand-primary: #047857; $brand-accent: #0E9F6E;")

    assert_includes css, "--app-bg: #EDF0EF"
    assert_includes css, "--muted: #5B6B66"
    assert_includes css, "rgba(10, 22, 19, 0.05)"
    assert_includes css, "--bs-body-bg: #EDF0EF"
    assert_empty warnings
  end

  def test_unknown_palette_fails
    assert_raises(Sass::CompileError) { compile("$neutral-palette: dark;") }
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
