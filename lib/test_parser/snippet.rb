require 'ruby2ruby'

module TestParser
  class Snippet

    attr_reader :sexp

    def initialize(sexp)
      raise ArgumentError unless sexp
      @sexp = sexp
    end

    def to_code
      @to_code ||= Ruby2Ruby.new.process(sexp.deep_clone)
    end

    def get_block
      Snippet.new(sexp[3])
    end

  end
end