class Notification < ApplicationRecord
  belongs_to :user
  include Rails.application.routes.url_helpers

  def notif_link
    case self.path
    #liked post notif
    when 'Post'
      feed_path(self.id)
    #liked comm notif
    when 'Comment'
      feed_path(self.id)

    when 'FriendRequest'
      "/friends"
    end
  end

end
