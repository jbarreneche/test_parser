require 'spec_helper'

require 'test_parser/rspec'

describe TestParser::RSpec do
  describe '.find_test_suite!' do
    context 'within test_project' do

      before(:all) do
        @test_suite = TestParser::RSpec.find_tests!(path_for_test_project)
        @test_names = @test_suite.map(&:identification)
      end

      it 'finds all the test_suite' do
        @test_suite.should have(2).test_suite
      end

      it 'finds nested test_suite' do
        @test_names.should include('Life/with death sentence/should(be_alive)')
        test = @test_suite[@test_names.index('Life/with death sentence/should(be_alive)')]
        test.file.should == (path_for_test_project('spec/example_spec.rb')).to_s
        test.extras[:line_number].should == 11
      end

      it 'finds not nested test_suite' do
        @test_names.should include('Life/actually lives')
        test = @test_suite[@test_names.index('Life/actually lives')]
    
        test.file.should == (path_for_test_project('spec/example_spec.rb')).to_s
        test.extras[:line_number].should == 5
      end

    end
  end
end