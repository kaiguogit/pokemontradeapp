  def image_url(id)
    # "https://img.pokemondb.net/artwork/#{name.downcase}.jpg"
    #"http://assets.pokemon.com/assets/cms2/img/pokedex/detail/#{id_to_index(id)}.png"
    "http://serebii.net/pokemongo/pokemon/#{id_to_index(id)}.png"
  end

  def id_to_index(number)
    result = number.to_s
    if result.length < 3
      result = "0" * (3 - result.length) + result
    else
      result
    end
  end


require "open-uri"
(1..151).each do |a|
  open("#{image_url(a)}") {|f|
   File.open("#{id_to_index(a)}-3d.png","wb") do |file|
     file.puts f.read
   end
  }
end
