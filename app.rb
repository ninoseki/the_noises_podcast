require 'sinatra'

configure do
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") do |lib|
    require File.basename(lib, '.*')
  end
end

get '/' do
  File.read(File.join('public', 'index.html'))
end

# set a cache setting
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

  cached_rss = @cache.get('rss')
  unless cached_rss
    logger.info('renew a rss')
    rss = TheNoises::Podcast.new.rss
    @cache.set('rss', rss)
  end

  return cached_rss || rss
end
