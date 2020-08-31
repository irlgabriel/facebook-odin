class HomeController < ApplicationController

  

  def index
    if user_signed_in? 
      redirect_to '/feed'
    end
  end

  def profile
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC')
    @friends = @user.friends
  end

end
