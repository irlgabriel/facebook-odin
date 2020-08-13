class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      redirect_to feed_path
    else
      render new_post_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
  
end
