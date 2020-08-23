class FriendsController < ApplicationController
  

  def home
    @users = User.all.to_ary.select { |user| user != current_user }
  end

  def like
    @liked_by = current_user
    
  end

end
