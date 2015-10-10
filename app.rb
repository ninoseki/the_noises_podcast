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

get '/rss' do
  content_type 'application/xml'

  TheNoises::Podcast.new.rss
end
