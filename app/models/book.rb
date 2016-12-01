class Book < ApplicationRecord
  belongs_to :category

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors, foreign_key: :book_id
  has_many :reviews, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :activities, as: :trackable, class_name: "PublicActivity::Activity",
    foreign_key: "trackable_id", dependent: :destroy

  accepts_nested_attributes_for :authors,
    reject_if: lambda {|a| a[:name].blank?}, allow_destroy: true

  default_scope -> {order created_at: :desc}

  scope :most_books, ->{order(sum_point: :desc).limit(6)}

  scope :reading, ->(user_id) do
    includes(:marks).where(marks: {user_id: user_id, mark_read: 1})
  end

  scope :read, ->(user_id) do
    includes(:marks).where(marks: {user_id: user_id, mark_read: 2})
  end

  scope :favorite, ->(user_id) do
    includes(:marks).where(marks: {user_id: user_id, favorite: true})
  end

  validates :title, presence: true, length: {maximum: 50}
  validates :category, presence: true
  # validates :publish_date, presence: true

  mount_uploader :photo, PhotoUploader

  include PublicActivity::Model

  STATUS = ["reading", "read", "favorite"]
end
