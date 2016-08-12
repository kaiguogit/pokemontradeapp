class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :pokemon
  # belongs_to :pokemon_trade, class_name: :Pokemon, foreign_key: :pokemon_trade_id
  has_and_belongs_to_many :carts
  has_one :wishlist

end