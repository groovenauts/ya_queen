# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ya_queen/version'

Gem::Specification.new do |spec|
  spec.name          = "ya_queen"
  spec.version       = YaQueen::VERSION
  spec.authors       = ["akima"]
  spec.email         = ["akima@groovenauts.jp"]
  spec.description   = %q{ya_queen supports to define complicated capistrano tasks and roles}
  spec.summary       = %q{ya_queen supports to define complicated capistrano tasks and roles}
  spec.homepage      = "https://github.com/groovenauts/ya_queen"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
