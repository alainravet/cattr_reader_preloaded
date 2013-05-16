# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cattr_reader_preloaded/version'

Gem::Specification.new do |spec|
  spec.name          = "cattr_reader_preloaded"
  spec.version       = CattrReaderPreloaded::VERSION
  spec.authors       = ["Alain Ravet"]
  spec.email         = ["alainravet@gmail.com"]
  spec.description   = 'asynchronously precompute and cache values when a class/module is loaded, not on the 1st call.'
  spec.summary       = 'asynchronously precompute and cache values when a class/module is loaded, not on the 1st call.'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
end
