class Supports::Book
  attr_reader :book

  def initialize book
    @book = book
  end

  Settings.rate.list_rate.each do |rate|
    define_method rate do
      instance_variable_set "@#{rate}", @book.reviews.where(rate:
        Settings.rate.send(rate)).size
    end
  end

  def sum_rate
    sum = 0
    Settings.rate.list_rate.each do |rate|
      sum += send(rate)
    end
    sum
  end

  def books
    @books ||= Book.all
  end

  def categories
    @categories ||= Category.all
  end
end