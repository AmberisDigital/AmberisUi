require "bootstrap"
require "dartsass-rails"
require "tom-select-rails"

module AmberisUi
  # No isolate_namespace: the apps use the helpers and partials directly.
  # Rails adds app/assets/* of the engine to config.assets.paths, which
  # dartsass-rails passes on as Sass load paths — so an app only needs
  # `@import "amberis_ui";`.
  class Engine < ::Rails::Engine
  end
end
