module TestParser
  class TestInformation < Struct.new(:type, :identification, :file, :extras)

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