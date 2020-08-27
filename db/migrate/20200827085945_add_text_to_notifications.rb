class AddTextToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :text, :string
  end
end
