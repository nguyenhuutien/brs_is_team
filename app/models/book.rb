class Book < ApplicationRecord
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :marks, dependent: :destroy

  scope :most_books, ->{order(rate: :desc).limit(6)}
  scope :list_books_with_author, ->author{where(author: author).order(rate: :desc)}

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
  validates :author, presence: true, length: {maximum: 40}
  validates :category, presence: true
  validates :publish_date, presence: true

  mount_uploader :photo, PhotoUploader

  STATUS = ["reading", "read", "favorite"]
end
