require "test_helper"
require "rails"
require "amberis_ui"

class EngineTest < Minitest::Test
  def test_engine_is_a_rails_engine
    assert_operator AmberisUi::Engine, :<, Rails::Engine
  end

  def test_engine_exposes_the_stylesheets_as_asset_path
    assert_includes AmberisUi::Engine.paths["app/assets"].existent_directories,
                    File.expand_path("../app/assets/stylesheets", __dir__)
  end
end
