require 'opal'
require 'date'
require 'browser'
require 'browser/http'
require 'sizzle'
require 'template'
require 'views/item'

class Client
  def fetch_and_render
    promise = Promise.new
    Browser::HTTP.get('/json') do
      on :success do |res|
        promise.resolve res.json
      end
      on :failure do |res|
        promise.resolve res
      end
    end
    promise.then do |json|
      view = View.new(json)
      view.render
    end.fail do |res|
      puts res
    end
  end
end

class View
  attr_reader :el, :items, :template

  def initialize(items)
    @el = $document[".items"]
    @items = items.map { |i| convert(i) }
    @template = Template["views/item"]
  end

  def convert_description(s)
    s.gsub(/(?:\n\r?|\r\n?)/, '<br>').gsub(/続きを読む/, '')
  end

  def convert_date(s)
    # "Sat, 28 Jan 2017 00:00:00 +0000" => "28 Jan 2017"
    s = s.split[1..3].join(" ")
    Date.parse(s).to_s
  end

  def convert(item)
    item["description"] = convert_description(item["description"])
    item["pub_date"] = convert_date(item["pub_date"])
    item
  end

  def render
    items.each do |item|
      DOM(template.render(item)).append_to el
    end
  end
end

$document.ready do
  client = Client.new
  client.fetch_and_render
end
