class HomeController < ApplicationController
  def index
    if current_user
      redirect_to '/feed'
    end
  end
end
