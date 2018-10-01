# frozen_string_literal: true

require 'test_helper'
require 'rss'

describe TheNoises::Podcast do
  before do
    @podcast = TheNoises::Podcast.new
    @podcast.expects(:items).returns(items_for_test)
  end

  it 'should have valid rss' do
    rss = RSS::Parser.parse(@podcast.rss.to_s)
    rss.must_be_instance_of(RSS::Rss)
  end

  it 'should have valid json' do
    json = JSON.parse(@podcast.json)
    json.length.must_equal 1
  end
end
