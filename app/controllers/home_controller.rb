class HomeController < ApplicationController
  def index
    @user = User.new


    if current_user
      redirect_to '/feed'
    end

  end

  def profile
    @user = User.find(params[:id])
  end

end
