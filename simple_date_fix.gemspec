# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_date_fix/version'

Gem::Specification.new do |gem|
  gem.name          = "simple_date_fix"
  gem.version       = SimpleDateFix::VERSION
  gem.authors       = ["Jeremy Green"]
  gem.email         = ["jeremy@octolabs.com"]
  gem.description   = %q{Fixes for date queries in AWS::Record}
  gem.summary       = %q{Fixes for date queries in AWS::Record}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

   gem.add_dependency "aws-sdk", "~> 1.8.0"
   gem.add_dependency "active_support", ">= 3.0.0"
   gem.add_development_dependency "rspec", ">= 2.0.0"

end
