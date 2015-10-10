require_relative './../lib/the_noises'

require 'minitest/spec'
require 'minitest/autorun'

def body_for_test
  File.read(
    File.expand_path('../index.html', __FILE__),
    encoding: 'EUC-JP:UTF-8'
  )
end

def items_for_test
  item = RSS::Rss::Channel::Item.new

  item.title = 'hoge'
  item.link = 'http://enterjam.net/podcast/noises/785.mp3'
  item.description = 'hogehoge'
  item.pubDate = 'Sat, 3 Oct 2015 00:00:00 +0000'

  [item]
end
