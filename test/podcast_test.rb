require 'test_helper'
require 'rss'

describe TheNoises::Podcast do
  before do
    @podcast = TheNoises::Podcast.new
    @podcast.expects(:items).returns(items_for_test)
  end

  it 'should have valid rss' do
    rss = RSS::Parser.parse(@podcast.rss)
    rss.must_be_instance_of(RSS::Rss)
  end
end
