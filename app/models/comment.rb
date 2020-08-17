class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  def self.author
    User.find(self.user_id)
  end

end
