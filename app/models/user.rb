class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :pending_invitations, -> { where confirmed: false }, class_name: :Invitation, foreign_key: :friend_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def friends
    friends_i_sent_invitation = Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_invitation = Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    friend_ids = friends_i_got_invitation + friends_i_sent_invitation
    User.where(id: friend_ids)
  end

  def is_friend?(user)
    Invitation.confirmed_record?(id, user.id)
  end

end
