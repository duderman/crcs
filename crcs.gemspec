# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crcs/version'

Gem::Specification.new do |spec|
  spec.name          = 'crcs'
  spec.version       = Crcs::VERSION
  spec.authors       = ['Nikolay Norkin']
  spec.email         = ['n.e.norkin@gmail.com']

  spec.summary       = 'Few CRC implementations in C for ruby'
  spec.description   = 'This gem contains three simple CRC32 algorithms'
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
