require 'test_parser/common'
require 'test_parser/minitest'
require 'test_parser/rspec'

module TestParser

  def all_tests(path, options = {})
    frameworks = options[:frameworks] ||= [:rspec, :minitest]
    path = sanitize_path(path)
    frameworks.collect_concat do |framework|
      send "#{framework}_tests", path, options[framework]
    end
  end

  def minitest_tests(path, options = nil)
    options ||= {}
    MiniTest.find_tests!(path, options)
  end

  def rspec_tests(path, options = nil)
    options ||= {}
    RSpec.find_tests!(path, options)
  end

  def require_all(path, glob)
    Dir[sanitize_path(path) + glob].each {|f| require f }
  end

  def sanitize_path(path)
    return path if path.is_a? Pathname
    Pathname.new(path)
  end

  extend self
end
