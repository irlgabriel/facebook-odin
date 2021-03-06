class FriendsController < ApplicationController


  def index
    @friends = current_user.friends
    
  end

  #only show suggestions of friends who (1) Are not me  (2) I have not already sent friends requests to 
  #(3) I am not already friends with (4) Have not sent me friend requests to me
  def suggestions
    @users = User.all.to_ary.select { |user| user != current_user &&
                                      !current_user.to_fr_ids.include?(user.id) &&
                                      !current_user.friends.include?(user) &&
                                      !current_user.from_fr_ids.include?(user.id)
                                       }
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
    Notification.where(user_id: @to, from_id: @from).destroy_all
    @f = Friendship.new(user_id: @to, friend_id: @from)
    if @f.save
      User.find(@from).friends.push(User.find(@to))
      @friend_request.destroy_all
      flash[:notice] = "Friendship accepted"
      redirect_to friends_find_path
    else
      flash[:alert] = "Couldnt accept friendship"
      redirect_to friends_find_path
    end
  end

  def decline
    @from = User.find(params[:from_id])
    @fr = FriendRequest.where(to_id: current_user.id, from_id: @from.id)
    @notif = Notification.where(user_id: current_user.id, from_id: @from.id)
    @notif.destroy_all
    @fr.destroy_all
    
    
    current_user.received_friend_requests.where(from_id: params[:from_id], to_id: current_user.id).destroy_all
    @from.sent_friend_requests.where(from_id: @from.id, to_id: current_user.id).destroy_all

    redirect_back  fallback_location: feed_path
  end

  def send_fr
    @to = User.find(params[:to_id])
    @from = current_user
    @fr = FriendRequest.new(to_id: @to.id, from_id: @from.id)
    if @fr.save
      #create a notification for @to user with a text
      Notification.new(from_id: @from.id, user_id: @to.id, text: "#{@from.fullname} sent you a friend request!", path:'FriendRequest').save
      flash[:notice] = "Friend Request Sent!"
      redirect_back fallback_location: feed_path
    else
      flash[:alert] = "Could not send Friend Request!"
      redirect_back fallback_location: feed_path
    end
  end

  def delete_friendship
    @fr = Friendship.where(friend_id: params[:friend_id], friend_id: current_user.id)
    @fr2 = Friendship.where(user_id: params[:friend_id], user_id: current_user.id)

    @fr2.destroy_all
    @fr.destroy_all
    flash[:alert] = 'Unfriended'
    redirect_back fallback_location: feed_path
  end



end