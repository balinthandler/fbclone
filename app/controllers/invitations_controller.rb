class InvitationsController < ApplicationController
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
      redirect_to user_path(invitation.user_id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def invitations_params
    params.require(:invitation).permit(:user_id, :friend_id)
  end

end
