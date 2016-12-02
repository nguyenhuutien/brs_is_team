class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :user, presence: true
  validates :review, presence: :true
end
