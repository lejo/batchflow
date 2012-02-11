# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "batchflow/version"

Gem::Specification.new do |s|
  s.name        = "batchflow"
  s.version     = Batchflow::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lejo Varughese", "Chaz Chandler", "Sreeni Anathakrishnan"]
  s.email       = ["lejo.varughese@gmail.com", "clc31@inbox.com"]
  s.homepage    = "https://github.com/lejo/batchflow"
  s.summary     = %q{batchflow is a background jobs dependency manager for Ruby web applications.}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "batchflow"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("eventmachine", "=0.12.10")
  s.add_development_dependency('rspec')
end
