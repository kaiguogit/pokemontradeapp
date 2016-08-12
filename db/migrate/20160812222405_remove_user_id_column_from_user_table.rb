class RemoveUserIdColumnFromUserTable < ActiveRecord::Migration
  def change
    remove_column :users, :user_wish_list_id
  end
end
