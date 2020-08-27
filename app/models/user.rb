class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  #friend requests
  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: 'to_id', dependent: :destroy
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'from_id', dependent: :destroy

  #friends associations
  has_many :friends, class_name: "User", foreign_key: "user_id"
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  
  #notifications
  has_many :notifications

  #activestorage
  has_one_attached :profile_picture, dependent: :destroy
  
  #activestorage validations
  validates :profile_picture, content_type: [:png, :jpg, :jpeg], size: {less_than: 10.megabytes, message: 'Size cannot exceed 10 MBs'}

  def fullname
    self.first_name + ' ' + self.last_name
  end
  
  #get ids of users that current user sent requests to
  def to_fr_ids
    self.sent_friend_requests.map {|fr| fr.to_id }
  end

  #notifications(friend requests for now)
  #def notifications
  #  self.received_friend_requests

  #end

end
