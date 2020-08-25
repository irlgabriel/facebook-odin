class LikesController < ApplicationController


  # POST /like
  def create
    #two params, user_id and thing_id(post or comment)
    @liked_by = User.find(params[:user_id])
    
    #determine if user is liking a post or a comment
    if params.include?(:post_id)
      @liked_thing = Post.find(params[:post_id])
    else
      @liked_thing = Comment.find(params[:comment_id])
    end
    
    #first check if liked_thing already has a like with user_id == @liked_by 

    already_liked = @liked_thing.likes.any? { |like| like.user_id == @liked_by.id }
    
    unless already_liked
      @liked_thing.likes.create(user_id: @liked_by.id)
      flash[:notice] = "Liked Post"
      redirect_to feed_path
    else
      to_delete = @liked_thing.likes.select {|like| like.user_id == @liked_by.id}
      to_delete.each {|like| like.destroy }
      flash[:alert] = "Unliked Post"
      redirect_to feed_path
    end
  end

end