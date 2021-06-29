class Post < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.created_ago(post)
    created_since_seconds = (Time.now - post.created_at).round
    if created_since_seconds / 60 < 1
      return "#{created_since_seconds} seconds ago"
    elsif created_since_seconds / 60 == 1
      return "#{created_since_seconds / 60} minute ago"
    elsif created_since_seconds / 60 / 60 < 1
      return "#{created_since_seconds / 60} minutes ago"
    elsif created_since_seconds / 60 / 60 == 1
      return "#{created_since_seconds / 60 / 60} hour ago"
    elsif created_since_seconds / 60 / 60 / 24 < 1
      return "#{created_since_seconds / 60 / 60} hours ago"
    elsif created_since_seconds / 60 / 60 / 24 == 1
      return "#{created_since_seconds / 60} day ago"
    else
      return "#{created_since_seconds / 60 / 60 / 24 } days ago"
    end
  end
end
