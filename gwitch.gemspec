# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'lib', 'gwitch', 'version')

Gem::Specification.new do |s|
  s.name        = "gwitch"
  s.version     = Gwitch::VERSION
  s.summary     = "Nintendo switch game API."
  s.description = "This gem can get switch games info from nintendo official API."

  s.required_ruby_version     = ">= 2.3.0"

  s.license = "MIT"

  s.author   = "Dounx"
  s.email    = "imdounx@gmail.com"
  s.homepage = "https://blog.dounx.me"

  s.require_paths = ["lib"]
  s.files = Dir["CHANGELOG.md", "LICENSE", "README.md", "lib/**/*"]

  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/dounx/gwitch/issues",
    "changelog_uri"     => "https://github.com/dounx/gwitch/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/dounx/gwitch/blob/master/README.md",
    "source_code_uri"   => "https://github.com/dounx/gwitch",
  }

  s.add_dependency "algoliasearch", "~> 1.27"
  s.add_dependency "countries", "~> 3.0"
end