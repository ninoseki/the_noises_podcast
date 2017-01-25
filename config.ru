require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'sinatra'
require 'sinatra/reloader' if development?
require_relative './lib/the_noises'
require_relative './app/application'

$stdout.sync = true
run TheNoisesApp
