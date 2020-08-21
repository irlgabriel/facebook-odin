class CommentsController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment created!"
      redirect_to root_path
    else
      render 'feed/index'
      flash[:notice] = "Could not create comment!"
    end
  end

  def show

  end

  def index

  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = 'Comment destryoed!'
      render 'feed/index'
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
