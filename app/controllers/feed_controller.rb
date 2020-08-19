class FeedController < ApplicationController
  def index
    @post = Post.new #for form_for
    @posts = Post.order('created_at DESC')
  end
end
