class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @invitation_from = Invitation.where(user_id: @user.id, friend_id: current_user.id).first
    @invitation_to = Invitation.where(user_id: current_user.id, friend_id: @user.id).first
  end

  private

  def users_params
    params.require(:user).permit(:user_id, :friend_id)
  end    

end
