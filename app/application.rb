require 'dalli'
require 'sinatra/base'

class TheNoisesApp < Sinatra::Base
  before '/*' do
    @memcached_client = Dalli::Client.new(
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
    File.read File.expand_path("../../public/index.html", __FILE__)
  end

  get '/rss' do
    content_type 'application/xml'

    cached_rss = @memcached_client.get('rss')
    unless cached_rss
      logger.info('renew rss')
      rss = TheNoises::Podcast.new.rss
      @memcached_client.set('rss', rss)
    end
    cached_rss || rss
  end

  get '/json' do
    content_type :json

    cached_json = @memcached_client.get('json')
    unless cached_json
      logger.info('renew json')
      json = TheNoises::Podcast.new.json
      @memcached_client.set('json', json)
    end
    cached_json || json
  end
end
