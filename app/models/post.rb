class Post < ApplicationRecord
  belongs_to :author, class_name:'User', foreign_key: :user_id
  has_many :comments



  validates :body, presence: true

  def likes_count
    self.likes
  end

end
