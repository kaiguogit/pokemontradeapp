class Move < ActiveRecord::Base
  has_many :pokemons

  has_many :quick_move_pokemons, class_name: :Pokemon, foreign_key: :quick_move_id
  has_many :charge_move_pokemons, class_name: :Pokemon, foreign_key: :charge_move_id
end