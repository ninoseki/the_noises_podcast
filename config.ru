require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'sinatra'
require 'logger'

$logger = Logger.new $stdout
$stdout.sync = true
if development?
  $logger.level = Logger::DEBUG
  require 'sinatra/reloader'
elsif production?
  $logger.level = Logger::INFO
end

require_relative './lib/the_noises'
require_relative './app/application'
run TheNoisesApp
