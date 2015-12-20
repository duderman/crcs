# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'digest/crc32/version'

Gem::Specification.new do |spec|
  spec.name          = 'crcs'
  spec.version       = Digest::CRC32::VERSION
  spec.authors       = ['Nikolay Norkin']
  spec.email         = ['n.e.norkin@gmail.com']

  spec.summary       = 'Few CRC implementations in C for ruby'
  spec.description   = 'This gem contains three simple CRC32 algorithms'
  spec.homepage      = 'https://github.com/duderman/crcs'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.extensions    = ['ext/digest/crc32/extconf.rb']
  spec.require_paths = ['lib']
  spec.required_ruby_version = '~> 2.2'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rake-compiler', '~> 0.9'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end
