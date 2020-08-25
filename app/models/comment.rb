class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_many :likes
  validates :body, presence: true
  
  
  def self.author
    User.find(self.user_id)
  end

  def self.posted_by
    Post.find(self.post_id)
  end

  def liked_by
    self.likes.map {|like| like.user_id}
  end

end
