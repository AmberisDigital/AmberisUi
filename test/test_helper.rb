require "minitest/autorun"
require "sass-embedded"

module SassHelper
  STYLESHEETS = File.expand_path("../app/assets/stylesheets", __dir__)
  BOOTSTRAP   = File.join(Gem.loaded_specs.fetch("bootstrap").full_gem_path, "assets/stylesheets")
  TOM_SELECT  = File.join(Gem.loaded_specs.fetch("tom-select-rails").full_gem_path, "vendor/assets/stylesheets")

  # Compiles `@import "amberis_ui"` with the given app settings in front, as
  # an app's application.scss does. Returns [css, warnings]; only @warn
  # messages count, not Sass deprecation notices about Bootstrap's @import.
  def compile(settings = "")
    warnings = []
    logger = Object.new
    logger.define_singleton_method(:warn) { |message, context| warnings << message unless context.deprecation }
    logger.define_singleton_method(:debug) { |*| }

    css = Sass.compile_string(
      "#{settings}\n@import \"amberis_ui\";",
      load_paths: [STYLESHEETS, BOOTSTRAP, TOM_SELECT],
      logger: logger,
      quiet_deps: true
    ).css
    [css, warnings]
  end
end
