# frozen_string_literal: true

require 'template'
require 'views/item'

module OpalApp
  class ItemView
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def template
      Template["views/item"]
    end

    def element
      DOM(template.render(item))
    end
  end
end
