require 'bundler/setup'
require 'jasmine-headless-webkit'
require 'rspec/core/rake_task'
require 'keystone'

require_relative 'config/environment'

task :default => ['jasmine:headless']

# desc "Run rspec specs"
# RSpec::Core::RakeTask.new(:rspec) do |t|
#   t.rspec_opts = '-dcfd --require rspec/spec_helper'
# end

desc "Runs jasmine specs"
Jasmine::Headless::Task.new('jasmine:headless') do |t|
  t.colors = true
  t.keep_on_error = true
  t.jasmine_config = 'spec/jasmine/support/jasmine.yml'
end

desc "Run asset compiler"
Keystone::RakeTask.new(:assets) do |t|
  t.config_file = "config/assets.rb"
  t.output_path = 'public/assets'
end