class BookAuthor < ApplicationRecord
  belongs_to :book
  belongs_to :author

  after_create :send_notification

  private
  def send_notification
    self.author.favorite_users.each do |user|
      notification = Notification.create! book_id: self.book_id, author_id: self.author_id,
        recipient_id: user.id
      channel = user.email + "_notification_channel"
      user.update_attributes new_notification: (user.new_notification + 1)
      NotificationService.new(channel: channel, book: notification.book,
        author: notification.author, notification: notification).perform
    end
  end
end
