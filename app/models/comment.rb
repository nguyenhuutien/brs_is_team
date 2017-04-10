class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :user, presence: true
  validates :review, presence: true
  validates :content, presence: true

  after_create :create_comment_activity

  include PublicActivity::Model

  def children_comments
    Comment.where parent_id: self.id
  end

  def replied_comment
    Comment.find_by id: self.reply_id
  end

  def replied_user
    comment = self.replied_comment
    if comment
      comment.user
    end
  end

  def self_reply?
    self.replied_user == self.user
  end

  def create_comment_activity
    review.create_activity key: "comments" , owner: user
  end
end
