class Book < ApplicationRecord
  belongs_to :category

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors, foreign_key: :book_id
  has_many :reviews, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :notifications, dependent: :destroy

  accepts_nested_attributes_for :authors,
    reject_if: lambda {|a| a[:name].blank?}, allow_destroy: true

  default_scope -> {order created_at: :desc}

  validates :title, presence: true, length: {maximum: 50}
  validates :category, presence: true
  validates :publish_date, presence: true
end
