require 'rspec/core'

require 'test_parser/parser/common'
require 'test_parser/extensions/rspec'
require 'test_parser/snippet_source/line_number'

module TestParser
  module Parser
    class RSpec

      attr_reader :example

      def self.type
        :rspec2
      end

      def self.find_tests(path, options = {})
        glob = options[:glob] || 'spec/**/*_spec.rb'

        ::RSpec.with_world ::RSpec::Core::World.new do |world|

          TestParser.require_all(path, glob)

          groups   = world.example_groups
          examples = groups.collect_concat(&:descendant_filtered_examples)
          examples.map do |example|
            new(example).build_test
          end
        end
      end

      include Common

      def initialize(example)
        @example = example
      end

      def identification
        @identification ||= path_to_example.join('/')
      end

      def snippet_source
        @snippet_source ||= SnippetSource::LineNumber.new(file_name, line_number)
      end

      def snippet
        @snippet ||= snippet_source.snippet
      end

      def file_name
        example.file_path
      end

      def line_number
        example.metadata[:line_number]
      end

      private

      def path_to_example
        example_groups_names + [example_description]
      end

      def example_groups_names
        example.example_group.ancestors.map(&:display_name).reverse
      end

      def example_description
        unless example.description.empty?
          example.description
        else
          snippet.get_block.to_code
        end
      end

    end
  end
end