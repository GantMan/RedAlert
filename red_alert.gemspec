# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

require File.expand_path('../lib/project/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "RedAlert"
  spec.version       = RedAlert::VERSION
  spec.authors       = ["Gant Laborde"]
  spec.email         = ["GantMan@gmail.com"]
  spec.description   = "RMQ Plugin adds efficient and dynamic alerts/sheets for RubyMotion Apps on iOS 7 & 8"
  spec.summary       = "RMQ Plugin adds efficient and dynamic alerts/sheets for RubyMotion Apps on iOS 7 & 8."
  spec.homepage      = "https://github.com/GantMan/RedAlert"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "ruby_motion_query", ">= 1.3.4"
  spec.add_development_dependency "rake", "~> 0"
end
