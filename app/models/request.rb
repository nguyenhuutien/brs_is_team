class Request < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :book_title, presence: true
  validates :book_author, presence: true
  validates :book_publish_date, presence: true

  default_scope -> {order created_at: :desc}

  enum status: [:waiting, :accept, :reject]
end
