class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  default_scope -> {order created_at: :desc}

  validates :name, presence: true
end
