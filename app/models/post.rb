class Post < ApplicationRecord
  belongs_to :author, class_name:'User', foreign_key: :user_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :body, presence: true
  
  def liked_by
    self.likes.map {|like| like.user_id }
  end

end