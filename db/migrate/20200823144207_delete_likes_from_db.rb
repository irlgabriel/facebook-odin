class DeleteLikesFromDb < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :likes
  end
end
