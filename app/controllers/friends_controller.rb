class FriendsController < ApplicationController
  
  def index

  end

  def suggestions
    @users = User.all.to_ary.select { |user| user != current_user }
  end

  def new

  end

  def requests
    @requests = current_user.received_friend_requests
  end

  def accept
    @from = params[:from_id]
  end

  def decline

  end

  def send_fr
    @to = User.find(params[:to_id]).id
    @from = current_user.id
    @fr = FriendRequest.new(to_id: @to, from_id: @from)
    if @fr.save
      flash[:notice] = "Friend Request Sent!"
      redirect_to friends_path
    else
      flash[:alert] = "Could not send Friend Request!"
      redirect_to friends_path
    end
  end

end
