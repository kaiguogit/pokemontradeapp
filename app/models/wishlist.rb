class Wishlist < ActiveRecord::Base
  belongs_to :listing
  has_many :pokemons

  def shuffle_list!
    array = pokemons.map{|p|p.id}
    array.shuffle!
    result_array = array.map{|id|Pokemon.find(id)}
    self.pokemons = result_array
    self.save
  end
end