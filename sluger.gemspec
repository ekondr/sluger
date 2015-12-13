lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sluger/version'

Gem::Specification.new do |spec|
  spec.name          = 'sluger'
  spec.version       = Sluger::VERSION
  spec.authors       = ['Eugene Kondratiuk']
  spec.email         = ['ekondr@gmail.com']

  spec.summary       = 'Sluger is a plugin for generating SEO friendly permalinks.'
  spec.description   = 'Sluger is a plugin for generating SEO friendly permalinks. It adds ability to use alphabetic ID for entities instead of numeric ID.'
  spec.homepage      = 'https://github.com/ekondr/sluger'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-rails'
end
