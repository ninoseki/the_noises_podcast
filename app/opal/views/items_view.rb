# frozen_string_literal: true

module OpalApp
  class ItemsView
    attr_accessor :element

    def initialize
      @element = $document[".items"]
    end

    def add_item(item)
      ItemView.new(item).element.append_to element
    end
  end
end
