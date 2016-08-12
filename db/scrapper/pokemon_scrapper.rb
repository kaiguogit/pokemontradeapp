require "nokogiri"
require 'open-uri'
# require 'colorize'
require 'pry-byebug'
require 'csv'


# def print_comment(comment)
#   puts ""
#   puts "By user: #{comment.user.name}".red.on_white
#   puts "#{comment.age}".blue.on_white
#   puts "#{comment.comment}".green
# end

# def hit_enter
#   puts "\nPlease hit enter for more"
#   loop do
#     break if STDIN.gets == "\n" 
#     puts "Invalid input, please hit enter"
#   end 
# end

# def wrong_argument
#   puts "Invalid argument"
#   puts "Usage: ruby scrapper.rb url [switches]"
#   puts "Switches: comments   Display all comments"
#   puts "Example: ruby scrapper.rb https://news.ycombinator.com/item?id=7663775"
#   puts "Example: ruby scrapper.rb https://news.ycombinator.com/item?id=7663775 comments"
# end

# def scrape(url)
#   post = Post.new(url)
#   puts "Post title: #{post.title}".red.bold.on_white
#   puts "Number of comments: #{post.comments.length}".yellow.bold
#   puts "Points: #{post.points}".blue.bold
#   puts "item_id: #{post.item_id}".magenta.bold
#   post
# end
def parse_html(url)
  @doc = Nokogiri::HTML(open(url).read)
end

def get_inner_text(css)
  @doc.search(css).map do |element|
    element.inner_text.strip
  end
end

parse_html("http://pokemondb.net/pokedex/national")

pokemon_names = get_inner_text("span.infocard-tall a.ent-name")

# index = get_inner_text("span.infocard-tall a.ent-name")

CSV.open("./pokemon_names.csv", "wb") do |csv|
  i = 1
  pokemon_names.each do |name|
    break if i == 152
    csv << [i, name]
    i += 1
  end
end
# puts pokemon_names[0..10]