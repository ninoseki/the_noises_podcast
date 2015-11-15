require 'rss'

module TheNoises
  class Podcast
    def initialize
      @title = 'ザ・ノイジーズ'
      @link = 'http://www.enterjam.com/?cat=5'
      @description = 'エンタジャムが生ぬるいネットラジオ業界に殴りこみ（笑）映画・ゲーム・アニメ・漫画・音楽から精神世界まで、あらゆるキーワードで自分が好きなことだけノンストップで語りつくすネットラジオ！'
      @language = 'ja-JP'
      @image = 'https://pbs.twimg.com/profile_images/2414394300/71o5q8aqlciezq0590i1.jpeg'
    end

    def rss
      @rss = RSS::Rss.new('2.0')
      @rss.channel = channel
      items.each { |item| @rss.channel.items << item }

      @rss.to_s
    end

    def items
      Parser.new.items.map(&:to_rss_item)
    end

    def image
      image = RSS::Rss::Channel::Image.new

      image.url = @image
      image.title = @title
      image.link = @link
      image.do_validate = false

      image
    end

    def channel
      channel = RSS::Rss::Channel.new
      channel.title = @title
      channel.link = @link
      channel.description = @description
      channel.language = @language
      channel.image = image

      channel
    end
  end
end
