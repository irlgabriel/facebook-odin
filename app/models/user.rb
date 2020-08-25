class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  has_many :posts
  has_many :comments
  has_one_attached :profile_picture
  
  validates :profile_picture, attached: true, content_type: [:png, :jpg, :jpeg], size: {less_than: 10.megabytes, message: 'Size cannot exceed 10 MBs'}

  def fullname
    self.first_name + ' ' + self.last_name
  end
  
  

end
