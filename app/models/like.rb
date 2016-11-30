class Like < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates :review, presence: true
  validates :user, presence: true
end
