class Mark < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum mark_read: [:nothing, :reading, :read]
end