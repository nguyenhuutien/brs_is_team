class BooksController < ApplicationController
  load_and_authorize_resource
  before_action :load_data

  def show
  end

  private
  def load_data
    @books = Book.all
    @supports = Supports::Book.new @book
    @mark = current_user.marks.find_by book_id: @book.id
    unless @mark
      @mark = current_user.marks.create! book_id: @book.id
    end
  end
end
