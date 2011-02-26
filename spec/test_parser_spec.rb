require 'spec_helper'

require 'test_parser'

describe TestParser do
    
  describe ".all_tests" do

    it "collects all the test from the default frameworks" do
      stub_frameworks!

      tests = TestParser.all_tests(path_for_test_project)
      tests.should =~ [:rspec, :minitest]
    end
    
    context "when :parsers are specified" do
      it 'collects only for the given parsers' do
        stub_frameworks!
        
        options = {:parsers => [TestParser::Parser::RSpec]}
        tests   = TestParser.all_tests(path_for_test_project, options)
        tests.should == [:rspec]
      end
    end
    
    def stub_frameworks!
      TestParser::Parser::RSpec.stub(:find_tests) { [:rspec]}
      TestParser::Parser::MiniTest.stub(:find_tests) {[:minitest]}
    end

  end
end