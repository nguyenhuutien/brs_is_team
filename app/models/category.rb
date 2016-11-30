class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true

  def sum_book
    books.size
  end
end
