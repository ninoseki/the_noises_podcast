require 'opal'
require 'date'
require 'browser'
require 'browser/http'
require 'sizzle'

require 'models/item'
require 'views/item_view'
require 'views/items_view'

module OpalApp
  class Application

    attr_reader :items_view

    def initialize
      @items_view = ItemsView.new
    end

    def run
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
        json.each { |params| items_view.add_item Item.new(params) }
      end.fail do |res|
        puts res
      end
    end
  end
end

$document.ready do
  OpalApp::Application.new.run
end
