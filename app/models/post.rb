class Post < ApplicationRecord
  belongs_to :author, class_name:'User', foreign_key: :user_id
  has_many :comments
  validates :body, presence: true

  @likes = 0

  def likes_count
    @likes
  end

end
