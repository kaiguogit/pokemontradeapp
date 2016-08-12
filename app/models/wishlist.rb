class Wishlist < ActiveRecord::Base
  belongs_to :listing
  has_many :pokemons
end