require 'test_helper'
require 'rss'

describe TheNoises::Podcast do
  before do
    @podcast = TheNoises::Podcast.new
  end

  it 'should have valid rss' do
    @podcast.stub :items, items_for_test do
      rss = RSS::Parser.parse(@podcast.rss)
      rss.must_be_instance_of(RSS::Rss)
    end
  end
end
