class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.references :from
      t.references :to
      t.timestamps
    end
  end
end
