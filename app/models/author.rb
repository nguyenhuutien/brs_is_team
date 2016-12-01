class Author < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors, foreign_key: :author_id

  validates :name, presence: true
end