require 'rss'
# http://www.apple.com/jp/itunes/podcasts/specs.html#rss
module TheNoises
  class Item
    def initialize(element)
      @element = element
    end

    def number
      m = title.force_encoding('UTF-8').match(/第(\d+)回/)
      m.nil? ? nil : m[1]
    end

    def link
      "http://enterjam.net/podcast/noises/#{number}.mp3"
    end

    def title
      @title ||= @element.css('h2').first.text
    end

    def pub_date
      @pub_date ||= Date.parse(@element.css('li.date').last.attribute('datetime').text).rfc822
    end

    def description
      @description ||= @element.css('p').first.text.chomp.force_encoding('UTF-8')
    end

    def valid?
      [number, title, link, description, pub_date].all?
    end

    def to_h
      {
        number: number,
        link: link,
        title: title,
        pub_date: pub_date,
        description: description
      }
    end

    def to_rss_item
      item = RSS::Rss::Channel::Item.new

      item.title = title
      item.link = link
      item.description = description
      item.pubDate = pub_date
      # set guid
      item.guid = RSS::Rss::Channel::Item::Guid.new
      item.guid.content = link
      item.guid.isPermaLink = true
      # set enclosure
      item.enclosure = RSS::Rss::Channel::Item::Enclosure.new
      item.enclosure.url = link
      item.enclosure.length = 0
      item.enclosure.type = 'audio/mpeg'

      item
    end
  end
end
