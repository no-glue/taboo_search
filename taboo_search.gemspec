# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'taboo_search/version'

Gem::Specification.new do |spec|
  spec.name          = "taboo_search"
  spec.version       = TabooSearch::VERSION
  spec.authors       = ["no-glue"]
  spec.email         = ["nikola_pav@eunet.rs"]
  spec.description   = %q{taboo search to solve travelling salesman}
  spec.summary       = %q{taboo search to solve travelling salesman}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "spec"
end
