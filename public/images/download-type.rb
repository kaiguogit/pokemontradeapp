require "open-uri"
require "csv"

(1..151).each do |a|
  open("http://pokeapi.co/api/v2/pokemon/#{a}") {|f|
   File.open("#{id_to_index(a)}-3d.png","wb") do |file|
     file.puts f.read
   end
  }
end

CSV.open("./pokemon_types.csv", "wb") do |csv|
  i = 1
  pokemon_names.each do |name|
    break if i == 152
    csv << [i, name]
    i += 1
  end
end