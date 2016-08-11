class AddColumnUserIdToPokemon < ActiveRecord::Migration
  def change
    change_table :pokemons do |t|
      t.belongs_to :user
    end
  end
end
