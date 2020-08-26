class FriendsController < ApplicationController
  
  def index
    @friends = current_user.friends
    
  end

  #only show suggestions of friends who (1) Are not me and (2) I have not already sent friends requests to 
  #(3-> soon) I am not already friends with
  def suggestions
    @users = User.all.to_ary.select { |user| user != current_user && !current_user.to_fr_ids.include?(user.id)}
    @requests = current_user.received_friend_requests
  end


  def requests
    @requests = current_user.received_friend_requests
  end

  #kind of a 'create' method
  def accept
    @from = params[:from_id]
    @to = current_user.id
    @friend_request = FriendRequest.where(to_id: @to, from_id: @from)
    @f = Friendship.new(user_id: @to, friend_id: @from)
    if @f.save
      @friend_request.destroy_all
      flash[:notice] = "Friendship accepted"
      redirect_to find_friends_path
    else
      flash[:alert] = "Couldnt accept friendship"
      redirect_to find_friends_path
    end
  end

  def decline
    @fr = FriendRequest.find(to_id: current_user.id, from_id: params[:from_id])
    @fr.delete
    redirect_to find_friends_path
  end

  def send_fr
    @to = User.find(params[:to_id]).id
    @from = current_user.id
    @fr = FriendRequest.new(to_id: @to, from_id: @from)
    if @fr.save
      flash[:notice] = "Friend Request Sent!"
      redirect_to friends_find_path
    else
      flash[:alert] = "Could not send Friend Request!"
      redirect_to friends_find_path
    end
  end

end
