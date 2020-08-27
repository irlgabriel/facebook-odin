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
      Notification.new(user_id: @post.author.id, from_id: current_user.id).save
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
      flash[:notice] = 'Comment destroyed!'
      render 'feed/index'
    end

  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    if @comment.save 
      redirect_to feed_url
      flash[:notice] = 'Comment edited successfully!'
    else
      render feed_url
      flash[:alert] = 'Could not edit the comment!'
    end
    
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
