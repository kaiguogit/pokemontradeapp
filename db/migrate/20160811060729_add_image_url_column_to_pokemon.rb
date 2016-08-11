class AddImageUrlColumnToPokemon < ActiveRecord::Migration
  def change
    add_column :pokemons, :image_url, :string
  end
end
