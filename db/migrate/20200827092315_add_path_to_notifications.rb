class AddPathToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :path, :string
  end
end
