# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "static_site_builder/version"

Gem::Specification.new do |spec|
  spec.name          = "static_site_builder"
  spec.version       = StaticSiteBuilder::VERSION
  spec.authors       = ["Michael Telford"]
  spec.email         = ["michael.telford@live.com"]

  spec.summary       = "Static site builder."
  spec.description   = "Gem for building static content websites from markdown."
  spec.homepage      = "https://github.com/michaeltelford/static_site_builder"
  spec.license       = "MIT"

  spec.required_ruby_version = '~> 2'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = ["site_builder"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.11"

  spec.add_runtime_dependency "redcarpet", "~> 3.4.0"
  spec.add_runtime_dependency "thor", "~> 0.20"
end
