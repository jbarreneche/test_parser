require_relative 'common'

module TestParser
  module SnippetSource
    class LineNumber
      
      attr_reader :file, :line_number

      include Common

      def initialize(file, line_number)
        @file, @line_number = file, line_number
      end
      
      def snippet
        source_code.extract_code_from_line(line_number)
      end

    end
  end
end