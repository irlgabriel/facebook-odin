class FeedController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.order('created_at DESC')
  end
end
