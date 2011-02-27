require 'optparse'
require 'test_parser'

require 'test_parser/test_formatter/yaml'

module TestParser
  class CommandLine

    attr_reader :stdout, :stderr

    def initialize(options, stdout = $stdout, stderr = $stderr)
      @stdout, @stderr   = stdout, stderr
      @registered_values = []
      @libs              = []
      configure_options(options)
    end

    def run
      tests = TestParser.all_tests(test_suite_path, parse_options)
      output_stream << format_tests(tests)
    end

    def parse_options
      {
        :libs => @libs
      }
    end

    def test_suite_path
      @test_suite_path || '.'
    end

    def output_stream
      $stdout
    end

    def format_tests(tests)
      @formater ||= yaml_formatter
      @formater.format(tests)
    end

    private

    def yaml_formatter
      TestFormatter::YAML
    end

    def configure_options(options)
      OptionParser.new do |parser|
        parser.banner = "Usage: test_parser [options] [directory]"
        
        parser.on('-I DIRECTORY', 'specify $LOAD_PATH directory (may be used more than once)') do |dir|
          append_libs(dir)
        end

        parser.on('-f', '--format FORMATTER', 'Choose a formatter',
                  '  y[aml] - YAML format') do |o|
          set_formater(o)
        end

        parser.on_tail('-h', '--help', "This is it!") do
          puts parser
          exit
        end
        
      end.parse!(options)

      extract_test_suite_path(options)
    end

    def append_libs(libs)
      @libs += libs.split(':')
    end

    def extract_test_suite_path(args)
      @test_suite_path = args.pop

      unless args.empty?
        log_err "Unknown use for values: #{args.inspect}"
      end
    end

    def puts(*args)
      stdout.puts *args
    end

    def log_err(*args)
      stderr.puts *args 
    end

    def set_formater(format)
      case format
      when /y(aml)?/i
        @formatter = yaml_formatter
      else
        log_err "Unknown formatter #{format}"
      end
    end
    
  end
end