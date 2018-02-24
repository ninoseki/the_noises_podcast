require 'sinatra/base'
require 'opal'
require 'opal/sprockets'

class MainController < Sinatra::Base
  set :views, File.expand_path("../../views", __FILE__)

  get '/' do
    locals = {}
    locals[:sprockets] = settings.sprockets if settings && settings.respond_to?(:sprockets)
    locals[:prefix] = settings.prefix if settings && settings.respond_to?(:prefix)
    erb :index, locals: locals
  end
end
