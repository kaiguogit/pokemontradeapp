
require "nokogiri"
require 'open-uri'
# require 'colorize'
require 'pry-byebug'
require 'csv'





def parse_html(url)
  @doc = Nokogiri::HTML(open(url).read)
end

def get_inner_text(css)
  @doc.search(css).map do |element|
    element.inner_text.strip
  end
end


parse_html("http://pokemongo.gamepress.gg/charge-moves")

charge_moves = get_inner_text("td > a")
p charge_moves

# index = get_inner_text("span.infocard-tall a.ent-name")

CSV.open("./charge_moves.csv", "wb") do |csv|
  charge_moves.each do |move|
    csv << [move]
  end
end
