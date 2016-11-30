class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :user, presence: true
  validates :book, presence: true
  validates :content, presence: true
  validates :rate, presence: true

  default_scope -> {order created_at: :desc}
end
