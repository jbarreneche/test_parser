require 'spec_helper'

require 'test_parser'
describe TestParser::MiniTest do
  before(:all) do
    MiniTest::Unit::TestCase.reset
  end
  after(:all) do
    MiniTest::Unit::TestCase.reset
  end

  describe '.find_tests!' do

    context 'within test_project' do
      before(:all) do
        @tests = TestParser::MiniTest.find_tests! path_for_test_project
        @test_identifications = @tests.map(&:identification)
      end

      it 'finds all the tests' do
        @tests.should have(2).tests
      end

      it 'finds normally declared test' do
        @test_identifications.should include('TestSomething#test_foo')
        test = @tests[@test_identifications.index('TestSomething#test_foo')]
        test.file.should == (path_for_test_project('test/example_test.rb')).to_s
        test.extras[:method_name].should == 'test_foo'
      end

      it 'finds module shared tests' do
        @test_identifications.should include('TestSomething#test_truth')
        test = @tests[@test_identifications.index('TestSomething#test_truth')]
        test.file.should == (path_for_test_project('test/test_helper.rb')).to_s
        test.extras[:method_name].should == 'test_truth'
      end
    end
  end
end