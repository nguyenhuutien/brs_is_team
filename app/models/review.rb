class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates :content, presence: true
  validates :rate, presence: true

  default_scope -> {order created_at: :desc}
end
