# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'casper_pets/version'

Gem::Specification.new do |spec|
  spec.name          = "casper_pets"
  spec.version       = CasperPets::VERSION
  spec.authors       = ["Sean Devine"]
  spec.email         = ["barelyknown@icloud.com"]
  spec.summary       = %q{Count pet sleeping behaviors.}
  spec.description   = spec.summary
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "http", "~> 0.6.2"
  spec.add_dependency "nokogiri", "~> 1.6.3.1"
  spec.add_dependency "gendered", "0.0.4"
end
