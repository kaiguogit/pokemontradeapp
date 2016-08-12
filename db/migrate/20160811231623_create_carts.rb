class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.timestamps
    end
    create_join_table :carts, :listings
  end
end
