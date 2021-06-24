class InvitationsController < ApplicationController
  def create
    @invitation = Invitation.new(user_id: current_user.id, friend_id: params[:id])
    @invitation.save
    redirect_to user_path(params[:id])
  end

  def destroy
    invitation = Invitation.where(user_id: params[:id1], friend_id: params[:id2]).first
    invitation.destroy
    redirect_to user_path(params[:id2])
  end

  def update
    invitation = Invitation.find(params[:id])
    invitation.update(confirmed: true)
    redirect_to user_path(invitation.friend_id)
  end


end
