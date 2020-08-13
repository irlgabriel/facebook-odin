class FriendsController < ApplicationController

  def home
    @users = User.all.to_ary.select { |user| user != current_user }
  end

end
