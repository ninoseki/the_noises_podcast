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
    @parser.items.length.must_equal 10
  end

  it 'should hava valid item' do
    item = @parser.items.first

    item.title.must_equal '第785回 ネットラジオ ザ・ノイジーズ 本日のお題：さらば青春！クルーズ移転記念！思い出の岩本町事務所で自由に語ってみよう！！'
    item.pub_date.must_equal 'Sat, 3 Oct 2015 00:00:00 +0000'
    item.description.must_include 'クルーズがとうとう'
    item.link.must_equal 'http://enterjam.net/podcast/noises/785.mp3'
  end
end
