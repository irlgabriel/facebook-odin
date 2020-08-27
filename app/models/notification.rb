class Notification < ApplicationRecord
  belongs_to :user

  def notif_link
    case self.path
    when 'Post'
      '#'
    when 'Comment'
      '#'
    when 'FriendRequest'
      '/friends'
    end
  end

end
