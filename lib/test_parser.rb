require 'test_parser/parser/common'
require 'test_parser/parser/minitest'
require 'test_parser/parser/rspec'

module TestParser

  DEFAULT_PARSERS = [Parser::MiniTest, Parser::RSpec]

  def all_tests(path, options = {})
    parsers = options[:parsers] ||= DEFAULT_PARSERS
    path    = sanitize_path(path)
    libs    = options[:libs] || []

    libs << 'spec'
    add_libs_to_load_path(path, libs)

    parsers.collect_concat do |parser|
      parser.find_tests(path, options[parser.type] || {})
    end
  end

  def require_all(path, glob)
    Dir[sanitize_path(path) + glob].each {|f| require f }
  end

  def sanitize_path(path)
    return path if path.is_a? Pathname

    Pathname.new(path).expand_path
  end

  extend self
  
  private
  
  def add_libs_to_load_path(path, libs)
    libs.each do |lib|
      dir = (path + lib).expand_path.to_s
      $LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)
    end
  end
  
end
