class UserMailer < ApplicationMailer
  default from: 'facebook@odin.com'

  def welcome_mail
    @user = current_user
    @url = root_path
  end

end
