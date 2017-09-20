require 'dalli'
require 'logger'
require 'json'
require 'sinatra/base'

class APIController < Sinatra::Base

  logger = Logger.new(STDOUT)

  configure :development do
    register Sinatra::Reloader
    logger.level = Logger::DEBUG
  end

  configure :production do
    logger.level = Logger::ERROR
  end

  configure :production, :development do
    enable :logging
    use Rack::CommonLogger, logger
  end

  before do
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
  get '/rss' do
    puts be_logged_params.to_json
    cached_rss = @memcached_client.get('rss')
    unless cached_rss
      logger.info('renew rss')
      rss = TheNoises::Podcast.new.rss
      @memcached_client.set('rss', rss)
    end

    content_type 'application/xml'
    cached_rss || rss
  end

  get '/json' do
    cached_json = @memcached_client.get('json')
    unless cached_json
      logger.info('renew json')
      json = TheNoises::Podcast.new.json
      @memcached_client.set('json', json)
    end

    content_type :json
    cached_json || json
  end

  def be_logged_params
    headers = request.env.select { |k, _v| k.start_with?("HTTP") }
    headers.merge(params)
  end
end
