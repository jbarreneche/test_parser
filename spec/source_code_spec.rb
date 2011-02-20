require 'spec_helper'
require 'test_parser/source_code'

describe TestParser::SourceCode do
  include FakeFS::SpecHelpers

  before(:each) do
    File.open('standard_class_source.rb', 'w') do |f|
      f << standard_class_source
    end
    File.open('dsl_source.rb', 'w') do |f|
      f << dsl_source
    end
  end

  after(:each) do
    TestParser::SourceCode.clear_cache
  end

  it 'has the sexp of the original file' do
    sexp = RubyParser.new.parse standard_class_source
    TestParser::SourceCode.for('standard_class_source.rb').sexp.should == sexp
  end

  describe '.extract_method' do
    it 'finds the method definition from the method name' do
      snippet = TestParser::SourceCode.for('standard_class_source.rb').extract_method('method')
      snippet.to_code.should match_code(<<-METHOD)
        def method(some)
          puts some
        end
      METHOD
    end
  end

  describe '.extract_code_from_line' do
    it 'finds the line with its block' do
      snippet = TestParser::SourceCode.for('dsl_source.rb').extract_code_from_line(2)
      snippet.to_code.should match_code(<<-METHOD)
        method 'ble' do
          testing_something
        end
      METHOD
    end
  end

  def standard_class_source
    <<-SOURCE
      class A
        def method(some)
          puts some
        end
      end
    SOURCE
  end

  def dsl_source
    <<-SOURCE
      calling :something do 
        method 'ble' do
          testing_something
        end
      end
    SOURCE
  end
end