require 'sinatra'
require 'sinatra/reloader' if development?

configure do
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") do |lib|
    require File.basename(lib, '.*')
  end
end

configure :development do
  register Sinatra::Reloader
end

get '/' do
  File.read(File.join('public', 'index.html'))
end

before '/rss' do
  require 'dalli'
  @cache = Dalli::Client.new(
    (ENV['MEMCACHIER_SERVERS'] || 'localhost').split(','),
    {
      username: ENV['MEMCACHIER_USERNAME'] || '',
      password: ENV['MEMCACHIER_PASSWORD'] || '',
      failover: true,
      socket_timeout: 1.5,
      socket_failure_delay: 0.2,
      expires_in: 3600 * 24
    }
  )
end

get '/rss' do
  content_type 'application/xml'

  rss = @cache.get('rss') || TheNoises::Podcast.new.rss
  @cache.set('rss', rss) unless @cache.get('rss')

  return rss
end
