class CreatePokemon < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :cp
      t.timestamps
    end
  end
end
