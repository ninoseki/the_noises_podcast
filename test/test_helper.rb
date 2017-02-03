ENV['RACK_ENV'] = 'test'
require 'webmock/minitest'
require 'mocha/mini_test'
require 'minitest/spec'
require 'minitest/autorun'
require 'rack/test'

require_relative '../lib/the_noises'
require_relative '../app/controllers/api'
require_relative '../app/controllers/main'

require_relative '../app/opal/models/item'

WebMock.disable_net_connect!

def body_for_test
  File.read(
    File.expand_path('../index.html', __FILE__)
  )
end

def items_for_test
  article = Oga.parse_html(
    File.read(File.expand_path("../article.html", __FILE__))
  )

  item = TheNoises::Item.new(article)
  [item]
end

def stubbing_request
  stub_request(:get, "http://www.enterjam.com/?cat=5").
    with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby' }).
    to_return(status: 200, body: body_for_test, headers: {})
end
