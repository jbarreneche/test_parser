require 'ruby_parser'
require 'test_parser/snippet'

module TestParser

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
      Snippet.new(method_sexp)
    end

    def extract_code_from_line(line_number)
      method_calls = sexp.enum_for(:each_of_type, :iter)
      code_sexp    = method_calls.find {|sexp| sexp[1].line == line_number }
      Snippet.new(code_sexp)
    end

  end

end