class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_many :activities, as: :trackable, class_name: "PublicActivity::Activity",
    foreign_key: "trackable_id", dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :user, presence: true
  validates :book, presence: true
  validates :content, presence: true
  validates :rate, presence: true

  default_scope -> {order created_at: :desc}

  after_create :create_review_activity
  after_create :update_rate_book

  include PublicActivity::Model

  ["likes", "comments"].each do |f|
    define_method "sum_#{f}" do
      self.send(f).size
    end
  end

  private
  def create_review_activity
    book.create_activity key: "reviews" , owner: user
  end
end