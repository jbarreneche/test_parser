module TestParser
  class TestInformation

    attr_reader :type, :identification, :snippet_source

    def initialize(type, identification, snippet_source)
      @type           = type
      @identification = identification
      @snippet_source = snippet_source
    end

    def snippet
      source_code = SourceCode.for(file)
      case type
      when :rspec2
        source_code.extract_code_from_line(extras[:line_number])
      when :minitest
        source_code.extract_method(extras[:method_name])
      end
    end

  end
end