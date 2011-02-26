require 'bundler'
Bundler.setup
Bundler.require :default, :test

support_glob = File.join(File.dirname(__FILE__), 'support', '**', '*.rb')
Dir[support_glob].each {|f| require f }

require 'fakefs/spec_helpers'

RSpec.configure do |config|
  config.include ProjectsPaths
end