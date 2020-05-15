class FriendshipsController < ApplicationController
  def create
    Friendship.create(user_id: current_user.id, friend_id: params[:friend_id])
    Friendship.create(user_id: params[:friend_id], friend_id: current_user.id)
    flash[:notice] = 'Added friend.'
    redirect_to '/dashboard'
  end
end
