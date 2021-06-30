class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

         
  has_many :posts, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :pending_invitations, -> { where confirmed: false }, class_name: :Invitation, foreign_key: :friend_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  after_commit :add_default_avatar, on: [:create, :update]
  
  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.firstname = provider_data.info.first_name
      user.lastname = provider_data.info.last_name
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end   

  def friends
    friends_i_sent_invitation = Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_invitation = Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    friend_ids = friends_i_got_invitation + friends_i_sent_invitation
    User.where(id: friend_ids)
  end

  def is_friend?(user)
    Invitation.confirmed_record?(id, user.id)
  end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "300x300!")
    else
      "/default_profile.jpg"
    end
  end

  def avatar_icon
    if avatar.attached?
      avatar.variant(resize: "100x100!")
    else
      "/default_profile.jpg"
    end
  end

  private
  def add_default_avatar
    unless avatar.attached?
        avatar.attach(
          io: File.open(
            Rails.root.join(
              'app', 'assets', 'images', 'default_profile.jpg'
            )
          ),
          filename: 'default_profile.jpg',
          content_type: 'image/jpg'
        )
    end
  end

end
