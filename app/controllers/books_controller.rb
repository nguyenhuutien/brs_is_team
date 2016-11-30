class BooksController < ApplicationController
  load_and_authorize_resource
  before_action :load_data, only: :show

  def index
    @q = @books.ransack params[:q]
    @books = @q.result.page(params[:page]).per Settings.per_page
  end

  def show
  end

  private
  def load_data
    @supports = Supports::Book.new @book
    @mark = current_user.marks.find_by book_id: @book.id
    unless @mark
      @mark = current_user.marks.create! book_id: @book.id
    end
  end
end
