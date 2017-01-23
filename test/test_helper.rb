require_relative './../lib/the_noises'

require 'webmock/minitest'
require 'mocha/mini_test'
require 'minitest/spec'
require 'minitest/autorun'


def body_for_test
  File.read(
    File.expand_path('../index.html', __FILE__)
  )
end

def items_for_test
  article = Oga.parse_html(
    File.read(File.expand_path("../article.html", __FILE__))
  )

  item = TheNoises::Item.new(article)
  [item]
end
