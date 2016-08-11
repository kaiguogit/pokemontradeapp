class Species < ActiveRecord::Base
  has_many :pokemons

  def image_url
    "https://img.pokemondb.net/artwork/#{name.downcase}.jpg"
  end
end