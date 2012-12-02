require 'bundler'
Bundler.require

require_relative 'config/environment'
require_relative 'app/app'
require_relative 'app/keystone'

pipeline = Keystone.bootstrap("#{File.dirname(__FILE__)}/config/assets.rb")
Keystone::Server.pipeline = pipeline