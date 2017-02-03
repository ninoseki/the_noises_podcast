require 'test_helper'

describe "OpalApp::Item" do
  before do
    params = {
      "title" => '第796回 ネットラジオ ザ・ノイジーズ 本日のお題：TVアニメ『ケイオスドラゴン 赤竜戦役』について語ろう！',
      "pub_date" => 'Sat, 14 Nov 2015 00:00:00 +0000',
      "description" => "今回はTVアニメ『ケイオスドラゴン 赤竜戦役』を語ります！
        続きを読む",
      "link" => 'http://enterjam.net/podcast/noises/796.mp3'
    }
    @item = OpalApp::Item.new(params)
  end

  describe "#description" do
    it "should convert line-break to <br>" do
      @item.description.must_include "<br>"
    end
    it "should delete '続きを読む'" do
      @item.description.wont_include "続きを読む"
    end
  end
end
