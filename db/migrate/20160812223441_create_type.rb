class CreateType < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name
      t.timestamps
    end

    create_join_table :types, :species
  end
end
