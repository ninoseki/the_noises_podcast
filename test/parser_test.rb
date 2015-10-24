require 'test_helper'

describe TheNoises::Parser do
  before do
    @parser = TheNoises::Parser.new

    stub_request(:get, 'http://www.enterjam.com/?cid=3').
      to_return(
        status: 200,
        body: body_for_test,
      )
  end

  it 'shoud have items' do
    @parser.items.length.must_equal 9
  end

  it 'should hava valid item' do
    item = @parser.items.first

    item.title.must_equal '第791回 ネットラジオ ザ・ノイジーズ 本日のお題：「「宇宙戦艦ヤマト」をつくった男 西崎義展の狂気」について語ろう！'
    item.pub_date.must_equal 'Sat, 24 Oct 2015 00:00:00 +0000'
    item.description.must_include 'こんな本出していいのか！'
    item.link.must_equal 'http://enterjam.net/podcast/noises/791.mp3'
  end
end
