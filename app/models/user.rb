
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :omniauthable

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :identities
end