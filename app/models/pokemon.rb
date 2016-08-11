class Pokemon < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  belongs_to :listing_trade, class_name: :Listing, foreign_key: :pokemon_trade_id
  belongs_to :species

  def image_url
    "https://img.pokemondb.net/artwork/#{species.name.downcase}.jpg"
  end
end