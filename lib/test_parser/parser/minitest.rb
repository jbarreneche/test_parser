require 'minitest/unit'

require 'test_parser/parser/common'
require 'test_parser/extensions/minitest'
require 'test_parser/snippet_source/method'

module TestParser
  module Parser
    class MiniTest

      attr_reader :klass, :test_method

      def self.type
        :minitest
      end

      def self.find_tests(path, options = {})
        glob = options[:glob] || 'test/**/*_test.rb'

        ::MiniTest::Unit.dont_install_at_exit!
      
        TestParser.require_all(path, glob)

        ::MiniTest::Unit::TestCase.test_suites.collect_concat do |klass|
          klass.test_methods.map do |test| 
            new(klass, test).build_test
          end
        end
      end

      include Common

      def initialize(klass, test_method)
        @klass, @test_method = klass, test_method
      end

      def identification
        "#{klass.name}##{test_method}"
      end

      def file_name
        klass.instance_method(test_method).source_location.first
      end

      def snippet_source
        @snippet_source ||= SnippetSource::Method.new(file_name, test_method)
      end

    end
  end
end