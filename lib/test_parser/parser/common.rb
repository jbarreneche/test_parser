require 'test_parser/test_information'

module TestParser
  module Parser
    module Common

      def build_test
        TestInformation.new(parser_type, identification, snippet_source)
      end

      def parser_type
        self.class.type
      end

    end
  end
end