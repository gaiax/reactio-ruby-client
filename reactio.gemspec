# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reactio/version'

Gem::Specification.new do |spec|
  spec.name          = "reactio"
  spec.version       = Reactio::VERSION
  spec.authors       = ["Hajime Sueyoshi"]
  spec.email         = ["hajime.sueyoshi@gaiax.com"]
  spec.summary       = %q{Reactio API Client}
  spec.description   = %q{The official Reactio API Client for ruby.}
  spec.homepage      = "https://reactio.jp/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
