# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'lib', 'gwitch', 'version')

Gem::Specification.new do |s|
  s.name        = "gwitch"
  s.version     = Gwitch::VERSION
  s.summary     = "Nintendo switch games' info API."
  s.description = "Gwitch can get switch games' info (including price) from Nintendo official API."

  s.required_ruby_version     = ">= 2.3.0"

  s.license = "MIT"

  s.author   = "Dounx"
  s.email    = "imdounx@gmail.com"
  s.homepage = "https://github.com/dounx/gwitch"

  s.require_paths = ["lib"]
  s.executables = ["gwitch"]
  s.files = Dir["CHANGELOG.md", "LICENSE", "README.md", "README-zh.md", "lib/**/*"]

  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/dounx/gwitch/issues",
    "changelog_uri"     => "https://github.com/dounx/gwitch/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/dounx/gwitch/blob/master/README.md",
    "source_code_uri"   => "https://github.com/dounx/gwitch",
  }

  s.add_dependency "algoliasearch", "~> 1.27"
  s.add_dependency "countries", "~> 3.0"
end