class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @incoming_request = Invitation.where(friend_id: current_user.id, confirmed: false)
  end
  
  def show
    @incoming_request = Invitation.where(friend_id: current_user.id, confirmed: false)
    @user = User.find(params[:id] || current_user.id)
    @joined = joined_since(@user)
    

    if Invitation.confirmed?(@user.id, current_user.id) || @user == current_user
      @posts = Post.where(user_id: params[:id])
    else
      @posts = []
    end


    @comment = Comment.new
    @invitation_from = Invitation.where(user_id: @user.id, friend_id: current_user.id).first
    @invitation_to = Invitation.where(user_id: current_user.id, friend_id: @user.id).first
  end

  private

  def joined_since(user)
    joined_since_seconds = (Time.now - user.created_at).round
    if joined_since_seconds / 60 < 1
      return "#{joined_since_seconds} seconds ago"
    elsif joined_since_seconds / 60 == 1
      return "#{joined_since_seconds / 60} minute ago"
    elsif joined_since_seconds / 60 / 60 < 1
      return "#{joined_since_seconds / 60} minutes ago"
    elsif joined_since_seconds / 60 / 60 == 1
      return "#{joined_since_seconds / 60 / 60} hour ago"
    elsif joined_since_seconds / 60 / 60 / 24 < 1
      return "#{joined_since_seconds / 60 / 60} hours ago"
    elsif joined_since_seconds / 60 / 60 / 24 == 1
      return "#{joined_since_seconds / 60} day ago"
    else
      return "#{joined_since_seconds / 60 / 60 / 24 } days ago"
    end
  end

  def user_params
    params.require(:user).permit(:user_id, :friend_id)
  end    

end
