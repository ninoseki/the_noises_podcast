require 'opal'
require 'sinatra/base'

class AssetsController < Sinatra::Base
  def initialize(*args, &bk)
    super(*args, &bk)
    @opal = Opal::Server.new { |s|
      s.append_path File.expand_path("../opal", __FILE__)
      s.main = 'application'
    }
  end

  get '/assets' do
    p "hoge"
    run @opal.sprockets
  end
end
