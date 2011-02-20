require 'minitest/autorun'

require 'bundler'
Bundler.setup
Bundler.require :default

require_relative '../spec/support/projects_paths'
require 'test_parser'

# This test is only to check there isn't any side effect for testing with Rspec
# while parsing RSpec specs.
class RSpecTest < MiniTest::Unit::TestCase

  include ProjectsPaths
  
  def test_rspec_parsing
    tests = TestParser::RSpec.find_tests!(path_for_test_project)
    test = tests.first
    assert_equal 'Life/actually lives', test.identification
    assert_equal path_for_test_project('spec/example_spec.rb').to_s, test.file
    assert_equal 5, test.extras[:line_number]
  end

end