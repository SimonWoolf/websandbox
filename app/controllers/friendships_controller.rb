class FriendshipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    newfriend = User.find(params[:user_id])
    current_user.add_friend(newfriend)
    flash[:notice] = "Added #{newfriend.name} as a friend"
    redirect_to users_path
  end

  def destroy
    oldfriend = User.find(params[:user_id])
    flash[:notice] = "Removed #{oldfriend.name} as a friend"
    current_user.remove_friend(oldfriend)
    redirect_to users_path
  end

end
