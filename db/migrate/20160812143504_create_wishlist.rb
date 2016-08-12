class CreateWishlist < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.references :listing
      t.timestamps
    end
    add_column :pokemons, :wishlist_id, :integer
    remove_column :listings, :pokemon_trade_id, :integer
  end
end
