class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  validates :body, presence: true
  
  def self.author
    User.find(self.user_id)
  end

  def self.posted_by
    Post.find(self.post_id)
  end


end
