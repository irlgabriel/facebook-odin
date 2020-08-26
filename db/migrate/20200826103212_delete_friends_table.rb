class DeleteFriendsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :friends
  end
end
