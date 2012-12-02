require './bootstrap'

if ENV['RACK_ENV'] == 'development'
  map '/assets' do
    run Keystone::Server
  end
end

map '/' do
  run App
end