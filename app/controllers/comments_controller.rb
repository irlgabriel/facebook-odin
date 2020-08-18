class CommentsController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.save
      flash[:notice] = "Comment created!"
      redirect_to 'feed/posts'
    else
      render 'feed/posts'
      flash[:notice] = "Could not create comment!"
    end
  end

  def show

  end

  def index

  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
