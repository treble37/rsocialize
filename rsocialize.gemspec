# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rsocialize/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bruce Park"]
  gem.email         = ["bruce at binarywebpark.com"]
  gem.description   = %q{Provides a simple way to add social media buttons to your rails application}
  gem.summary       = %q{Provides a simple way to add social media buttons to your rails application.  It's a ruby wrapper for the sharrre jQuery plugin.'}
  gem.homepage      = ""
  
  #gem.files         = `git ls-files`.split($\)
  #gem.files = Dir["{lib}/**/*"] + ["LICENSE", "README.md"]
  #gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  #gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.name          = "rsocialize"
  gem.require_paths = ["lib"]
  gem.version       = Rsocialize::VERSION
  
  gem.add_development_dependency "rspec",">=3.3.0"
  gem.add_development_dependency "rake",">=0.9.2.2"
  gem.add_development_dependency "pry", ">=0.10.1"
  gem.add_development_dependency "codeclimate-test-reporter"
  gem.add_runtime_dependency "curb", "~>0.8.2"
  gem.add_runtime_dependency "activesupport", ">= 3.2.8"
  gem.add_runtime_dependency "nokogiri", ">= 1.5.5"
  gem.add_runtime_dependency "actionpack", ">= 3.2.8"
end
