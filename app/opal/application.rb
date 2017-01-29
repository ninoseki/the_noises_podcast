require 'opal'
require 'browser'
require 'browser/http'
require 'sizzle'
require 'template'
require 'views/item'

$document.ready do
  Browser::HTTP.get "/json" do
    on :success do |res|
    end
  end
end
