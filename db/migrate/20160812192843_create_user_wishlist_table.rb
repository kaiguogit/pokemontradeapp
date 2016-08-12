class CreateUserWishlistTable < ActiveRecord::Migration
  def change
    create_table :user_wish_lists do |t|
      t.belongs_to :user 
      t.timestamps 
    end
    add_column :users, :user_wish_list_id, :integer
    add_column :pokemons, :user_wish_list_id, :integer 
  end
end
