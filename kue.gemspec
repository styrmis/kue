# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "kue/version"

Gem::Specification.new do |s|
  s.name        = "kue"
  s.version     = Kue::VERSION
  s.authors     = ["Daniel Watson"]
  s.email       = ["dan@dotnetguy.co.uk"]
  s.homepage    = ""
  s.summary     = %q{Kue is a simple key value store that uses ActiveRecord.}
  s.description = %q{Store arbitrary key value pairs for your application using kue's simple api'}

  s.rubyforge_project = "kue"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path  = 'lib'

  s.add_dependency 'activerecord', '~> 4.0.0'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry'
end
