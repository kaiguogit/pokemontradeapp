class Pokemon < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  belongs_to :listing_trade, class_name: :Listing, foreign_key: :pokemon_trade_id
  
  def image_url
    "https://img.pokemondb.net/artwork/#{name.downcase}.jpg"
  end
end