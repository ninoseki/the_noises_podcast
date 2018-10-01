# frozen_string_literal: true

require 'test_helper'

describe "Main" do
  def app
    MainController
  end

  include Rack::Test::Methods

  it "/" do
    get "/"
    last_response.content_type.must_include "text/html"
    last_response.body.must_include "Podcast"
  end
end
