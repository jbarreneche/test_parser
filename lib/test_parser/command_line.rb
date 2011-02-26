require 'test_parser'

require 'test_parser/test_formatter/yaml'

module TestParser
  class CommandLine

    LONG_RE     = /^(--\w+(?:-\w+)*)$/
    INC_LIB_RE  = %r{^-I([\w/]+(?::[\w/]+)*)$}

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
      until options.empty? do
        option = options.shift
        apply_option(option, options)
      end
      check_registered_values
    end

    def apply_option(option, remaining_opts)
      case option
      when LONG_RE
        apply_switch($1, remaining_opts)
      when INC_LIB_RE
        append_libs($1)
      else
        @registered_values << option
      end
    end

    def append_libs(libs)
      @libs += libs.split(':')
    end

    def check_registered_values
      case @registered_values.size
      when 0
        # Do nothing
      when 1
        @test_suite_path = @registered_values.first
      else
        @test_suite_path = @registered_values.pop
        log_err "Unknown use for values: #{@registered_values.inspect}"
      end
    end

    def puts(*args)
      stdout.puts *args
    end

    def log_err(*args)
      stderr.puts *args 
    end

  end
end