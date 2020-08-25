class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :post, null: true
      t.references :comment, nulL: true
      t.references :user
      t.timestamps
    end
  end
end
