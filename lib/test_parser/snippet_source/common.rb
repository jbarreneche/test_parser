require 'test_parser/source_code'

module TestParser
  module SnippetSource
    module Common

      def source_code
        SourceCode.for(file)
      end

    end  
  end
end
