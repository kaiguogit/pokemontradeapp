class CreateMovesTable < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.string :name
      t.string :move_type
      t.timestamps 
    end
    add_column :pokemons, :quick_move_id, :integer
    add_column :pokemons, :charge_move_id, :integer
  end
end
