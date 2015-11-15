require 'test_helper'

describe TheNoises::Parser do
  before do
    @parser = TheNoises::Parser.new

    stub_request(:get, 'http://www.enterjam.com/?cat=5').
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

    item.title.must_equal '第796回 ネットラジオ ザ・ノイジーズ 本日のお題：TVアニメ『ケイオスドラゴン 赤竜戦役』について語ろう！'
    item.pub_date.must_equal 'Sat, 14 Nov 2015 00:00:00 +0000'
    item.description.must_include '今回はTVアニメ『ケイオスドラゴン 赤竜戦役』を語ります！'
    item.link.must_equal 'http://enterjam.net/podcast/noises/796.mp3'
  end
end
