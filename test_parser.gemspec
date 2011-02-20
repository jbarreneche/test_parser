# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "test_parser/version"

Gem::Specification.new do |s|
  s.name        = "test_parser"
  s.version     = TestParser::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Juan Manuel Barreneche"]
  s.email       = ["juanmanuel.barreneche@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Retrieves information of your test suite}
  s.description = %q{Retrieves information of your test suite}

  s.rubyforge_project = "test_parser"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'ruby_parser', '~> 2.0.5'
  s.add_dependency 'ruby2ruby', '~> 1.2.5'
  s.add_dependency 'rspec-core', '~> 2.5.0'
  s.add_dependency 'minitest', '~> 2.0.2'

end
