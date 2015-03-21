# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
VERSION = "0.1"

Gem::Specification.new do |spec|
  spec.name          = "RedAlert"
  spec.version       = VERSION
  spec.authors       = ["Gant"]
  spec.email         = ["GantMan@gmail.com"]
  spec.description   = "Plugin adds efficient and dynamic alerts/sheets for RMQ"
  spec.summary       = "Plugin adds efficient and dynamic alerts/sheets for RMQ"
  spec.homepage      = "https://github.com/GantMan/RedAlert"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'ruby_motion_query', '>= 0.8.0'
  spec.add_development_dependency "rake"
end
