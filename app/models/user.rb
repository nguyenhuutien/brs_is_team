class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :omniauthable

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
  has_many :activities, as: :trackable, class_name: "PublicActivity::Activity",
    foreign_key: "owner_id", dependent: :destroy
  has_many :notifications, class_name: Notification.name,
    foreign_key: "recipient_id", dependent: :destroy
  has_many :favorite_authors, dependent: :destroy
  has_many :list_favorite_authors, through: :favorite_authors, source: :author

  scope :all_users, -> {where admin: false}

  mount_uploader :image, ImageUploader

  include PublicActivity::Model

  def user_reviews
    Review.where("user_id = ? OR user_id IN(SELECT followed_id FROM follows
      WHERE follower_id = ?)", self.id, self.id)
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def like? review
    self.likes.find_by(review_id: review.id) ? true : false
  end

  def favorite_author? author
    favorite_authors.find_by author_id: author.id
  end

  Book::STATUS.each do |status|
    define_method "size_#{status}" do
      if status == "favorite"
        self.marks.where(favorite: true).size
      else
        self.marks.send("#{status}").size
      end
    end
  end

  Book::STATUS.each_with_index do |status, i|
    define_method "list_#{status}" do
      if status == "favorite"
        Book.eager_load(:marks).where("favorite = 't' AND user_id = ?", self.id)
      else
        Book.eager_load(:marks).where("mark_read = ? AND user_id = ?", i + 1, self.id)
      end
    end
  end
end
