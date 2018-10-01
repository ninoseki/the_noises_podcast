# frozen_string_literal: true

require 'sinatra/base'
require 'opal'
require 'opal/sprockets'

class MainController < Sinatra::Base
  set :views, File.expand_path('../views', __dir__)

  get '/' do
    locals = {}
    locals[:sprockets] = settings.sprockets if settings&.respond_to?(:sprockets)
    locals[:prefix] = settings.prefix if settings&.respond_to?(:prefix)
    erb :index, locals: locals
  end
end
