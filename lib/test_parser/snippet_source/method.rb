require_relative 'common'

module TestParser
  module SnippetSource
    class Method
      
      attr_reader :file, :method_name

      include Common

      def initialize(file, method_name)
        @file, @method_name = file, method_name
      end
      
      def snippet
        source_code.extract_method(method_name)
      end
      
    end
  end
end

