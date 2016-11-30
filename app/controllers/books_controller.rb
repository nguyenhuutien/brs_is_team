class BooksController < ApplicationController
  def show
    @book = Book.first
    @books = Book.all
    @categories = Category.all
    @supports =  Supports::Book.new @book
  end
end