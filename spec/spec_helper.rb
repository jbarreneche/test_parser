require 'bundler'
Bundler.setup
Bundler.require :default, :test

Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each {|f| require f }

require 'fakefs/spec_helpers'

RSpec.configure do |config|
  config.include ProjectsPaths
end