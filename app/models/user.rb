class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :identities
  has_many :likes, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :active_relationships, class_name: Follow.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Follow.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
    foreign_key: "owner_id", dependent: :destroy
  has_many :notifications, class_name: Notification.name,
    foreign_key: "recipient_id", dependent: :destroy
  has_many :favorite_authors, dependent: :destroy
  has_many :list_favorite_authors, through: :favorite_authors, source: :author

  scope :all_users, -> {where admin: false}
end
