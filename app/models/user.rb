class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, on: :create
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password
  after_initialize :set_defaults

  def set_defaults
    self.status ||= 'Pending'
  end

  def bookmarked_videos
    Video.select('videos.*, tutorials.id as tutorial_id')
         .joins(:tutorial)
         .joins(:user_videos)
         .where(user_videos: { user_id: id })
         .order(:tutorial_id)
         .order(:position)
  end

  def friend_list(id)
    User.find(id).friends
  end
end
