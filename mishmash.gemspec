# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'mishmash'
  spec.version       = '0.1'
  spec.authors       = ['Ty Rauber']
  spec.email         = ['tyrauber@mac.com']
  spec.summary       = %q{ A ruby hash translation library }
  spec.description   = %q{ Given an input hash, output a translated hash with a given schema. Mishmash.new({a:1}).translate({a:b}) = {b:1} }
  spec.homepage      = 'https://github.com/tyrauber/Mishmash'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.2'
end
