
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :user, presence: true
  validates :review, presence: true
  validates :content, presence: true

  after_create :create_comment_activity

  include PublicActivity::Model

  def create_comment_activity
    review.create_activity key: "comments" , owner: user
  end
end
