require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'sinatra'
require 'logger'

$logger = Logger.new $stdout
if development?
  $stdout.sync = true
  $logger.level = Logger::INFO
  require 'sinatra/reloader'
elsif production?
  $logger.level = Logger::WARN
end

require './app'
run Sinatra::Application
