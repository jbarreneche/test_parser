require 'test_parser/source_code'
require 'test_parser/test_information'

module TestParser

  module Common

    def build_test(extras = {})
      TestInformation.new(parser_type, test_identification, test_file_name, extras)
    end

    def test_source_code
      SourceCode.for(test_file_name)
    end

  end
end