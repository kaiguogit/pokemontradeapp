class UserWishList < ActiveRecord::Base
  belongs_to :user
  has_many :pokemons
end 