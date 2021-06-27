class InvitationsController < ApplicationController
  def index
    @invitations = Invitation.where(friend_id: current_user.id, confirmed: false)
    @incoming_request = Invitation.where(friend_id: current_user.id, confirmed: false)
    friends_1 = Invitation.where(friend_id: current_user.id, confirmed: true).pluck("user_id")
    friends_2 = Invitation.where(user_id: current_user.id, confirmed: true).pluck("friend_id")
    friends_ids = friends_1 + friends_2
    @friends = User.where(id: friends_ids)

  end
  
  def create
    unless Invitation.where(user_id: params[:friend_id], friend_id: current_user.id).first
      @invitation = Invitation.new(user_id: current_user.id, friend_id: params[:friend_id])
      @invitation.save
      redirect_to user_path(params[:friend_id])
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    invitation = Invitation.where(user_id: params[:user_id], friend_id: params[:friend_id]).or(Invitation.where(user_id: params[:friend_id], friend_id: params[:user_id])).first
    unless invitation.nil?
      invitation.destroy
      if current_user.id == invitation.user_id
        redirect_to user_path(invitation.friend_id)
      else
        redirect_to user_path(invitation.user_id)
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    invitation = Invitation.where(user_id: params[:user_id], friend_id: params[:friend_id]).or(Invitation.where(user_id: params[:friend_id], friend_id: params[:user_id])).first
    unless invitation.nil?
      invitation.update(confirmed: true)
      redirect_to invitations_index_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def invitations_params
    params.require(:invitation).permit(:user_id, :friend_id)
  end

end
