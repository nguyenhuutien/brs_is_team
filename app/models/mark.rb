class Mark < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :book, presence: true
  validates :user, presence: true

  enum mark_read: [:nothing, :reading, :read]
end
