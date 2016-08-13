class Species < ActiveRecord::Base
  has_many :pokemons

  has_and_belongs_to_many :types

  def image_url
    # "https://img.pokemondb.net/artwork/#{name.downcase}.jpg"
    "./images/#{id_to_index(id)}.png"
  end

  def id_to_index(number)
    result = (number / 1000.0).to_s[2..-1]
    if result.length < 3
      result += "0" * (3 - result.length)
    else
      result
    end
  end
end