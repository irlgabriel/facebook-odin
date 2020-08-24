class FeedController < ApplicationController
  

  def index
    @users = User.all.to_ary.select { |user| user != current_user }
    @post = Post.new #for form_for
    @posts = Post.order('created_at DESC')
  end

  private


end
