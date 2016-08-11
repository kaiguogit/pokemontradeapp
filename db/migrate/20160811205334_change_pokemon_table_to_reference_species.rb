class ChangePokemonTableToReferenceSpecies < ActiveRecord::Migration
  def change
    add_column :pokemons, :species_id, :string
    remove_column :pokemons, :image_url
  end
end
