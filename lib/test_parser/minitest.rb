require 'minitest/unit'
require_relative 'extensions/minitest'

require 'test_parser'

module TestParser
  class MiniTest
    attr_reader :klass, :test_method

    def self.find_tests!(path, options = {})
      glob = options[:glob] || 'test/**/*_test.rb'

      ::MiniTest::Unit.dont_install_at_exit!
      
      TestParser.require_all(path, glob)

      ::MiniTest::Unit::TestCase.test_suites.collect_concat do |klass|
        klass.test_methods.map do |test| 
          new(klass, test).test_info
        end
      end
    end

    include Common

    def parser_type
      :minitest
    end

    def initialize(klass, test_method)
      @klass, @test_method = klass, test_method
    end

    def test_info
      build_test(:method_name => test_method)
    end

    def test_identification
      "#{klass.name}##{test_method}"
    end

    def test_file_name
      klass.instance_method(test_method).source_location.first
    end

  end

end