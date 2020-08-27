class AddFromIdToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :from
  end
end
