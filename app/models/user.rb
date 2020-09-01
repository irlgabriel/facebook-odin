class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:facebook]
         
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  #friend requests
  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: 'to_id', dependent: :destroy
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'from_id', dependent: :destroy

  #friends associations
  has_many :friends, class_name: "User", foreign_key: "user_id"
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  
  #likes
  has_many :likes, dependent: :destroy

  #notifications
  has_many :notifications

  #activestorage
  has_one_attached :profile_picture, dependent: :destroy
  has_one_attached :cover_picture, dependent: :destroy
  
  #activestorage validations
  validates :profile_picture, content_type: [:png, :jpg, :jpeg], size: {less_than: 10.megabytes, message: 'Size cannot exceed 10 MBs'}
  validates :cover_picture, content_type: [:png, :jpg, :jpeg], size: {less_than: 10.megabytes, message: 'Size cannot exceed 10 MBs'}

  #user info validations
  validates :first_name, :last_name, presence: true, length: {in: (3..20) }

  def fullname
    self.first_name + ' ' + self.last_name
  end
  
  #get ids of users that current user sent requests to
  def to_fr_ids
    self.sent_friend_requests.map {|fr| fr.to_id }
  end

  #get ids of users that sent me requests
  def from_fr_ids
    self.received_friend_requests.map {|fr| fr.from_id }
  end

  #oauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      
      user.email = auth.info.email
      
      #user.profile_picture.attach(auth.info.image)
      user.first_name = auth.info.name.split(/ /).second
      user.last_name = auth.info.name.split(/ /).first
      
      #user.first_name = auth.info.first_name
      #user.last_name = auth.info.last_name
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!
    end
  end

end
