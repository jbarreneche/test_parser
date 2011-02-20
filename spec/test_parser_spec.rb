require 'spec_helper'

require 'test_parser'

describe TestParser do
  
  describe ".minitest_tests" do
    it 'delegates test finding to TestParser::MiniTest' do
      TestParser::MiniTest.should_receive(:find_tests!).
        with(path_for_test_project, {}).and_return []
        
      TestParser.minitest_tests(path_for_test_project)
    end
    it 'passes extra options to TestParser::Minitest' do
      TestParser::MiniTest.should_receive(:find_tests!).
        with(path_for_test_project, {:some_option => true}).and_return []
        
      TestParser.minitest_tests(path_for_test_project, {:some_option => true})
    end
  end
  
  describe ".rspec_tests" do
    it 'delegates test finding to TestParser::RSpec' do
      TestParser::RSpec.should_receive(:find_tests!).
        with(path_for_test_project, {}).and_return []
        
      TestParser.rspec_tests(path_for_test_project)
    end
    it 'passes extra options to TestParser::RSpec' do
      TestParser::RSpec.should_receive(:find_tests!).
        with(path_for_test_project, {:some_option => true}).and_return []

      TestParser.rspec_tests(path_for_test_project, {:some_option => true})
    end
  end

  describe ".all_tests" do
    it "collects all the test from the default frameworks" do
      stub_frameworks

      tests = TestParser.all_tests(path_for_test_project)
      tests.should == [:rspec, :minitest]
    end
    
    context "when :frameworks are specified" do
      it 'collects only for the given frameworks' do
        stub_frameworks
        
        options = {:frameworks => [:rspec]}
        tests   = TestParser.all_tests(path_for_test_project, options)
        tests.should == [:rspec]
      end
    end
    
    def stub_frameworks
      TestParser::RSpec.stub(:find_tests!) { [:rspec]}
      TestParser::MiniTest.stub(:find_tests!) {[:minitest]}
    end
  end
end