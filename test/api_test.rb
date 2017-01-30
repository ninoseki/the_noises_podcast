require 'test_helper'
require 'dalli'
require 'date'
require 'json'
require 'rss'

describe "API" do

  def app
    APIController
  end

  include Rack::Test::Methods

  before do
    stubbing_request
  end

  describe "/rss" do
    before do
      client = mock
      client.expects(:get).returns(nil)
      client.expects(:set).returns(nil)
      Dalli::Client.stubs(:new).returns(client)
    end

    it "returns valid rss" do
      get "/rss"
      last_response.content_type.must_include "application/xml"
      rss = RSS::Parser.parse(last_response.body)
      item = rss.channel.items.first

      item.title.must_equal '第796回 ネットラジオ ザ・ノイジーズ 本日のお題：TVアニメ『ケイオスドラゴン 赤竜戦役』について語ろう！'
      item.pubDate.rfc822.must_equal 'Sat, 14 Nov 2015 00:00:00 +0000'
      item.description.must_include '今回はTVアニメ『ケイオスドラゴン 赤竜戦役』を語ります！'
      item.link.must_equal 'http://enterjam.net/podcast/noises/796.mp3'
    end
  end

  describe "/json" do
    before do
      client = mock
      client.expects(:get).returns(nil)
      client.expects(:set).returns(nil)
      Dalli::Client.stubs(:new).returns(client)
    end

    it "returns valid json" do
      get "/json"
      last_response.content_type.must_include "application/json"
      json = JSON.parse(last_response.body)
      item = json.first

      item["title"].must_equal '第796回 ネットラジオ ザ・ノイジーズ 本日のお題：TVアニメ『ケイオスドラゴン 赤竜戦役』について語ろう！'
      Date.parse(item["pub_date"]).rfc822.must_equal 'Sat, 14 Nov 2015 00:00:00 +0000'
      item["description"].must_include '今回はTVアニメ『ケイオスドラゴン 赤竜戦役』を語ります！'
      item["link"].must_equal 'http://enterjam.net/podcast/noises/796.mp3'
    end
  end

end
