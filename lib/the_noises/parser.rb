require 'oga'
require 'open-uri'

module TheNoises
  class Parser
    BASE_URL = 'http://www.enterjam.com/?cid=3'

    def items
      doc.css('div.entry').map do |e|
        item = TheNoises::Item.new(e)

        item.valid? ? item : nil
      end.compact
    end

    def doc
      @doc ||= Oga.parse_html(body)
    end

    def body
      @body ||= open(BASE_URL, 'r:EUC-JP').read.encode('UTF-8')
    end
  end
end
