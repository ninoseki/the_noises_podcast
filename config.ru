require 'rubygems'
require 'bundler/setup'
require 'dotenv/load'
require 'opal'
require 'opal-browser'
require 'opal/sprockets/server'
require 'rack'
require 'sinatra'
require 'sinatra/reloader' if development?
require_relative './lib/the_noises'
require_relative './app/controllers/api'
require_relative './app/controllers/main'

$stdout.sync = true

# Sprockets settings for Opal
opal = Opal::Sprockets::Server.new { |s|
  s.append_path 'app/opal'
  s.main = 'application'
}

sprockets   = opal.sprockets
prefix      = '/assets'
maps_prefix = '/__OPAL_SOURCE_MAPS__'
maps_app    = Opal::SourceMapServer.new(sprockets, maps_prefix)

# Monkeypatch sourcemap header support into sprockets
::Opal::Sprockets::SourceMapHeaderPatch.inject!(maps_prefix)

map maps_prefix do
  run maps_app
end

map prefix do
  run sprockets
end

MainController.set sprockets: sprockets, prefix: prefix
use APIController
run MainController
