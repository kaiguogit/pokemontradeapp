class CreateListingsTable < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.belongs_to :pokemon
      t.belongs_to :user
      t.integer :price
      t.string :status
      t.integer :pokemon_trade_id
      t.timestamps 
    end
  end
end
