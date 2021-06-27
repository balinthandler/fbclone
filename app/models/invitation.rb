class Invitation < ApplicationRecord
  belongs_to :user

  def self.is_exists?(id1, id2)
    case1 = !Invitation.where(user_id: id1, friend_id: id2).empty?
    case2 = !Invitation.where(user_id: id2, friend_id: id1).empty?
    case1 || case2
  end

  def self.confirmed?(id1, id2)
    case1 = !Invitation.where(user_id: id1, friend_id: id2, confirmed: true).empty?
    case2 = !Invitation.where(user_id: id2, friend_id: id1, confirmed: true).empty?
    case1 || case2
  end

  def self.find_invitation_by_users(id1, id2)
      Invitation.where(user_id: id1, friend_id: id2, confirmed: true)
  end

  def self.is_receiver?(id1, id2)
    Invitation.where(user_id: id1, friend_id: id2, confirmed: false)
  end


end
