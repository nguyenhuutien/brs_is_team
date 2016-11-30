class Book < ApplicationRecord
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :marks, dependent: :destroy

  mount_uploader :photo, PhotoUploader

  STATUS = ["reading", "read", "favorite"]
end
