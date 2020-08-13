class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      redirect_to feed_path
      flash[:notice] = 'Post created successfully'
    else
      render new_post_path
      flash[:notice] = "Couldn't create Post"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    if @post.save 
      flash[:notice] = "Post updated successfully"
      redirect_to feed_path
    else
      render edit_post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to feed_path
      flash[:notice] = "Post destroyed!"
    else
      render feed_path
      flash[:notice] = "Can't destroy Post"
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
  
end