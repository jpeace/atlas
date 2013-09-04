require 'bundler/setup'
require 'echoe'
require 'jasmine-headless-webkit'
require 'rspec/core/rake_task'
require 'keystone'

task :default => [:assets, :spec]

Echoe.new('atlas', '0.0.1') do |p|  
  p.description     = 'UI Framework'
  p.url             = 'http://musiconelive.com'
  p.author          = 'Music One Live'
  p.email           = 'admin@musiconelive.com'
  p.ignore_pattern  = FileList['.gitignore']  
  p.development_dependencies = []
  p.runtime_dependencies = []
end  

desc "Runs jasmine specs"
Jasmine::Headless::Task.new(:spec) do |t|
  t.colors = true
  t.keep_on_error = true
  t.jasmine_config = 'spec/support/jasmine.yml'
end

desc "Run asset compiler"
Keystone::RakeTask.new(:assets => :environment) do |t|
  t.config_file = 'lib/atlas/config/assets.rb'
  t.output_path = 'build'
end

desc "Loads environment"
task :environment do
  require './lib/atlas/config/environment'
  require './lib/atlas/support/keystone'
end