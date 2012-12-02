require 'sinatra'
require 'json'

class App < Sinatra::Base
  include Keystone::Server::Helpers

  set :root, "#{File.dirname(__FILE__)}/../"

  get '/' do
    erb :main
  end

  get '/load/:id' do
    if params[:id].to_i <= 0
      return {
        :success => false,
        :message => 'Fucked up dummy'
      }.to_json
    end

    name = if params[:id].to_i > 10
              'Jarrod'
            else
              'Peace'
            end
    {
      :success => true,
      :data => {
        :name => name,
        :age => params[:id].to_i
      }
    }.to_json
  end
end