class Item
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def description
    params["description"].gsub(/(?:\n\r?|\r\n?)/, '<br>').gsub(/続きを読む/, '')
  end

  def pub_date
    # "Sat, 28 Jan 2017 00:00:00 +0000" => "28 Jan 2017"
    # Dirty trick: Opal Date class doesn't support Capital abbr month name!
    date = params["pub_date"].split[1..3].map(&:downcase).join(" ")
    Date.parse(date).to_s
  end

  def title
    params["title"]
  end

  def link
    params["link"]
  end
end
