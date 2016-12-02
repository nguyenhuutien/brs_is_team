class NotificationJob < ApplicationJob
  queue_as :default

  def perform args
    ActionCable.server.broadcast args[:channel], {notification: args[:notification],
      book: args[:book], author: args[:author]}
  end
end
