class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def require_login
    if user_signed_in? 
      flash[:alert] = "You need to be signed up before proceeding"
      redirect_to new_user_session_path
    end
  end
end
