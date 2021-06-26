class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @incoming_request = Invitation.where(friend_id: current_user.id, confirmed: false)
  end
  
  def show
    @incoming_request = Invitation.where(friend_id: current_user.id, confirmed: false)
    @user = User.find(params[:id])
    @invitation_from = Invitation.where(user_id: @user.id, friend_id: current_user.id).first
    @invitation_to = Invitation.where(user_id: current_user.id, friend_id: @user.id).first
  end

  private

  def user_params
    params.require(:user).permit(:user_id, :friend_id)
  end    

end
