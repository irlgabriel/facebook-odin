class Notification < ApplicationRecord
  belongs_to :user

  def notif_link
    case self.path
    #liked post notif
    when 'Post'
      "feed/#{self.id}"
    #liked comm notif
    when 'Comment'
      "feed/#{self.id}"

    when 'FriendRequest'
      "/friends"
    end
  end

end
