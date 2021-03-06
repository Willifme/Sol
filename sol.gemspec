# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative "lib/sol"

Gem::Specification.new do |spec|
  spec.name          = "sol"
  spec.version       = Sol::VERSION
  spec.default_executable = "sol"
  spec.authors       = ["Willifme"]
  spec.email         = ["penguinwithwaffle@gmail.com"]
  spec.summary       = %q{A toy programming language.}
  spec.description   = %q{A toy programming language currently in basic development}
  spec.homepage      = "https://github.com/Willifme/Sol"
  spec.license       = "GPL-2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "racc", "~> 1.4"
  spec.add_development_dependency "rb-readline", "~> 0.5"
end
