class Pokemon < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  belongs_to :listing_trade, class_name: :Listing, foreign_key: :pokemon_trade_id
  belongs_to :species

  belongs_to :quick_move, class_name: :Move, foreign_key: :quick_move_id
  belongs_to :charge_move, class_name: :Move, foreign_key: :charge_move_id

  def image_url
    species.image_url
  end
end