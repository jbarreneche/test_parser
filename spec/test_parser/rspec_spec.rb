require 'spec_helper'

require 'test_parser/parser/rspec'

describe TestParser::Parser::RSpec do
  describe '.find_tests' do
    context 'within test_project' do

      include TestParser::Parser

      before(:all) do
        @test_suite = RSpec.find_tests(path_for_test_project)
        @test_names = @test_suite.map(&:identification)
      end

      it 'finds all the test_suite' do
        @test_suite.should have(2).test_suite
      end

      it 'finds nested test_suite' do
        @test_names.should include('Life/with death sentence/should(be_alive)')
        test = @test_suite[@test_names.index('Life/with death sentence/should(be_alive)')]

        test.file.should    == path_for('spec/example_spec.rb')
        test.snippet.should match_code(snippet_for('spec/example_spec.rb', 11))
      end

      it 'finds not nested test_suite' do
        @test_names.should include('Life/actually lives')
        test = @test_suite[@test_names.index('Life/actually lives')]
  
        test.file.should    == path_for('spec/example_spec.rb')
        test.snippet.should match_code(snippet_for('spec/example_spec.rb', 5))
      end

      def path_for(file)
        path_for_test_project(file).to_s
      end
      
      def snippet_for(file, line_number)
        TestParser::SourceCode.for(path_for(file)).extract_code_from_line(line_number)
      end

    end
  end
end
