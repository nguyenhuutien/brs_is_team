class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_many :activities, as: :trackable, class_name: "PublicActivity::Activity",
    foreign_key: "trackable_id", dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :user, presence: true
  validates :book, presence: true
  validates :content, presence: true
  validates :rate, presence: true

  default_scope -> {order created_at: :desc}

  after_create :create_review_activity

  include PublicActivity::Model

  def create_review_activity
    book.create_activity key: "reviews" , owner: user
  end
end
