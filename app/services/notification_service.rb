class NotificationService
  attr_reader :args

  def initialize args
    @notification = args[:notification]
    @book = args[:book]
    @author = args[:author]
    @channel = args[:channel]
  end

  def perform
    NotificationJob.perform_now channel: @channel, notification: @notification,
      book: @book , author: @author
  end
end
