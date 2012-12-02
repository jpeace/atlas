require 'bundler/setup'
require 'jasmine-headless-webkit'
require 'rspec/core/rake_task'
require 'keystone'

task :default => :spec

desc "Runs jasmine specs"
Jasmine::Headless::Task.new(:spec => :assets) do |t|
  t.colors = true
  t.keep_on_error = true
  t.jasmine_config = 'spec/jasmine/support/jasmine.yml'
end

desc "Run asset compiler"
Keystone::RakeTask.new(:assets => :bootstrap) do |t|
  t.config_file = "config/assets.rb"
  t.output_path = 'public/assets'
end

desc "Bootstrap system"
task :bootstrap do
  require './bootstrap'
end