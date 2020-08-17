class AddUJserIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :user
  end
end
