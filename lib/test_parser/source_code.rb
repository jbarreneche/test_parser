require 'ruby_parser'
require 'test_parser/snippet'

module TestParser

  SourceCodeError    = Class.new(StandardError)
  NoMethodFoundError = Class.new(SourceCodeError)
  NoCodeInLineError  = Class.new(SourceCodeError)

  class SourceCode < Snippet

    def self.source_codes
      @source_codes ||= begin
        parser = RubyParser.new
        Hash.new do |h, k|
          h[k] = new(parser.parse File.read(k))
        end
      end
    end

    def self.clear_cache
      @source_codes = nil
    end

    def self.for(filename)
      source_codes[File.expand_path(filename)]
    end

    def extract_method(name)
      name        = name.to_sym
      definitions = sexp.enum_for(:each_of_type, :defn)
      method_sexp = definitions.find {|def_sexp| def_sexp[1] == name }

      raise NoMethodFoundError unless method_sexp

      Snippet.new(method_sexp)
    end

    def extract_code_from_line(line_number)
      
      code_sexp = find_method_call_with_block(line_number)
      code_sexp ||= find_method_call_without_block(line_number)

      raise NoCodeInLineError unless code_sexp

      Snippet.new(code_sexp)
    end

    private
    
    def find_method_call_with_block(line_number)
      method_calls = sexp.enum_for(:each_of_type, :iter)
      method_calls.find {|sexp| sexp[1].line == line_number }
    end
    
    def find_method_call_without_block(line_number)
      method_calls = sexp.enum_for(:each_of_type, :call)
      method_calls.find do |sexp| 
        sexp[3][1] && sexp[3][1].line == line_number
      end
    end
    
  end

end