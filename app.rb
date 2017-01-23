require 'sinatra'

configure do
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") do |lib|
    require File.basename(lib, '.*')
  end
end

# set a cache setting
before '/*' do
  require 'dalli'
  @cache = Dalli::Client.new(
    (ENV['MEMCACHIER_SERVERS'] || 'localhost').split(','),
    {
      username: ENV['MEMCACHIER_USERNAME'] || '',
      password: ENV['MEMCACHIER_PASSWORD'] || '',
      failover: true,
      socket_timeout: 1.5,
      socket_failure_delay: 0.2,
      expires_in: 3600 * 12
    }
  )
end

get '/' do
  File.read(File.join('public', 'index.html'))
end

get '/rss' do
  content_type 'application/xml'

  cached_rss = @cache.get('rss')
  unless cached_rss
    logger.info('renew rss')
    rss = TheNoises::Podcast.new.rss
    @cache.set('rss', rss)
  end
  cached_rss || rss
end

get '/json' do
  content_type :json

  cached_json = @cache.get('json')
  unless cached_json
    logger.info('renew json')
    json = TheNoises::Podcast.new.json
    @cache.set('json', json)
  end
  cached_json || json
end
