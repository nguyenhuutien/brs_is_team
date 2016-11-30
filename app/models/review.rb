class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  default_scope -> {order created_at: :desc}
end
