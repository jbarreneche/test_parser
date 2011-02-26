module TestParser
  class TestInformation

    attr_reader :type, :identification, :snippet_source

    def initialize(type, identification, snippet_source)
      @type           = type
      @identification = identification
      @snippet_source = snippet_source
    end

    def snippet
      snippet_source.snippet
    end

    def file
      snippet_source.file
    end

  end
end