class Author < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors, foreign_key: :author_id
  has_many :notifications, dependent: :destroy
  has_many :favorite_authors, dependent: :destroy
  has_many :favorite_users, through: :favorite_authors, source: :user

  validates :name, presence: true
end
