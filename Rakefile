require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

task :default => [:test, :spec]
