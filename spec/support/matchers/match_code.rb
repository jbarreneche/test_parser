RSpec::Matchers.define :match_code do |expected|

  match do |actual|
    sexp_from(expected) == sexp_from(actual)
  end

  def sexp_from(obj)
    return obj.sexp if obj.respond_to? :sexp
    
    RubyParser.new.parse(obj)
  end

end