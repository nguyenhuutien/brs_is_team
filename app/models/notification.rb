class Notification < ApplicationRecord
  belongs_to :recipient, class_name: User.name
  belongs_to :author
  belongs_to :book

  default_scope -> {order created_at: :desc}

  validates :recipient, presence: true
  validates :author, presence: true
  validates :book, presence: true
end
