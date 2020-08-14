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
      render new_post_comment_path(@post)
    end
  end

  private

  def comment_params

  end
end
