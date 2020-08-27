class FeedController < ApplicationController
  before_action :destroy_notification

  def destroy_notification
    if params[:notification_id]
      @notif = Notification.find(params[:notification_id])
      @notif.destroy_all
    end
  end

  def index
    @users = User.all.to_ary.select { |user| user != current_user }
    @post = Post.new #for form_for
    @posts = Post.order('created_at DESC')
  end

  private


end
