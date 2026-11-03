require_relative "lib/amberis_ui/version"

Gem::Specification.new do |spec|
  spec.name        = "amberis_ui"
  spec.version     = AmberisUi::VERSION
  spec.authors     = ["Amberis Digital"]
  spec.email       = ["info@amberis-digital.com"]
  spec.summary     = "Shared look and layout for the Amberis apps"
  spec.description = "Design tokens, Bootstrap configuration, components and layout partials " \
                     "used by AmberisCockpit, AmberisFlow and AmberisCare. Apps only set their colours."
  spec.homepage    = "https://github.com/AmberisDigital/AmberisUi"

  # Internal gem, installed from git — never publish it to rubygems.org.
  spec.metadata["allowed_push_host"] = "https://gems.invalid"
  spec.metadata["source_code_uri"]   = spec.homepage
  spec.metadata["changelog_uri"]     = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.required_ruby_version = ">= 3.3"

  spec.files = Dir["{app,lib}/**/*", "README.md", "CHANGELOG.md"]

  spec.add_dependency "rails", "~> 8.1"
  spec.add_dependency "bootstrap", "~> 5.3"
  spec.add_dependency "dartsass-rails", ">= 0.5"
  spec.add_dependency "tom-select-rails", "~> 2.5"
end
