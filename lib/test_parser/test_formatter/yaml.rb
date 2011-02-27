require 'yaml'

module TestFormatter
  module YAML
    extend self
    
    def format(tests)
      tests.to_yaml
    end
  end
end