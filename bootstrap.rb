require 'bundler'
Bundler.require

require_relative 'config/environment'

pipeline = Keystone.bootstrap("#{File.dirname(__FILE__)}/config/assets.rb")
Keystone::Server.pipeline = pipeline