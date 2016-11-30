class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :omniauthable

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :identities
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: Follow.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Follow.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  mount_uploader :image, ImageUploader

  def user_reviews
    Review.where("user_id = ? OR user_id IN(SELECT followed_id FROM follows
      WHERE follower_id = ?)", self.id, self.id)
  end
end
