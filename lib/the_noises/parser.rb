require 'oga'
require 'open-uri'

module TheNoises
  class Parser
    BASE_URL = 'http://www.enterjam.com/?cat=5'

    def items
      doc.css('article.post').map do |e|
        item = TheNoises::Item.new(e)

        item.valid? ? item : nil
      end.compact
    end

    def doc
      @doc ||= Oga.parse_html(body)
    end

    def body
      @body ||= open(BASE_URL).read
    end
  end
end
