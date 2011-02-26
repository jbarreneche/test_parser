require 'spec_helper'

require 'test_parser/parser/minitest'

describe TestParser::Parser::MiniTest do

  include TestParser::Parser

  describe '.find_tests!' do

    context 'within test_project' do

      before(:all) do
        @tests = MiniTest.find_tests path_for_test_project
        @test_identifications = @tests.map(&:identification)
      end

      it 'finds all the tests' do
        @tests.should have(2).tests
      end

      it 'finds normally declared test' do
        @test_identifications.should include('TestSomething#test_foo')
        test = @tests[@test_identifications.index('TestSomething#test_foo')]

        expected_file = 'test/example_test.rb'

        test.file.should    == path_for(expected_file)
        test.snippet.should match_code(snippet_for(expected_file, 'test_foo'))
      end

      it 'finds module shared tests' do
        @test_identifications.should include('TestSomething#test_truth')
        test = @tests[@test_identifications.index('TestSomething#test_truth')]

        expected_file = 'test/test_helper.rb'

        test.file.should    == path_for(expected_file)
        test.snippet.should match_code(snippet_for(expected_file, 'test_truth'))
      end

      def path_for(file)
        path_for_test_project(file).to_s
      end
      
      def snippet_for(file, method_name)
        TestParser::SourceCode.for(path_for(file)).extract_method(method_name)
      end

    end
  end
end
