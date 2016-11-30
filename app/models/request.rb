class Request < ApplicationRecord
  belongs_to :user

  default_scope -> {order created_at: :desc}

  enum status: [:waiting, :accept, :reject]
end
