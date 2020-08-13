class HomeController < ApplicationController
  def index
    @user = User.new


    if current_user
      redirect_to '/feed'
    end

  end

  def profile
    
  end

end
