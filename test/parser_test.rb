require 'test_helper'

describe TheNoises::Parser do
  before do
    @parser = TheNoises::Parser.new
  end

  it 'shoud have items' do
    @parser.stub :body, body_for_test do
      @parser.items.length.must_equal 10
    end
  end

  it 'should hava valid item' do
    @parser.stub :body, body_for_test do
      item = @parser.items.first

      item.title.must_equal '第785回 ネットラジオ ザ・ノイジーズ 本日のお題：さらば青春！クルーズ移転記念！思い出の岩本町事務所で自由に語ってみよう！！'
      item.pub_date.must_equal 'Sat, 3 Oct 2015 00:00:00 +0000'
      item.description.must_include 'クルーズがとうとう'
      item.link.must_equal 'http://enterjam.net/podcast/noises/785.mp3'
    end
  end
end
