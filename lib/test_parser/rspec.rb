require 'rspec/core'
require_relative 'extensions/rspec'

require 'test_parser'

module TestParser
  class RSpec
    attr_reader :example

    def self.find_tests!(path, options = {})
      glob = options[:glob] || 'spec/**/*_spec.rb'

      ::RSpec.with_world ::RSpec::Core::World.new do |world|

        TestParser.require_all(path, glob)

        groups   = world.example_groups
        examples = groups.collect_concat(&:descendant_filtered_examples)
        examples.map do |example|
          new(example).test_info
        end
      end
    end

    include Common
    
    def initialize(example)
      @example = example
    end

    def parser_type
      :rspec2
    end

    def test_info
      build_test(:line_number => line_number)
    end

    def test_snippet
      @test_snippet ||= test_source_code.extract_code_from_line(line_number)
    end

    def test_file_name
      example.file_path
    end

    def test_identification
      (example_group_names.reverse + [example_description]).join('/')
    end

    def line_number
      example.metadata[:line_number]
    end

    def example_group_names
      example.example_group.ancestors.map(&:display_name)
    end

    def example_description
      unless example.description.empty? 
        example.description
      else
        test_snippet.get_block.to_code
      end
    end

  end
end