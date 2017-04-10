class ReviewsController < ApplicationController
  load_and_authorize_resource :book
  load_and_authorize_resource
  before_action :load_support, only: [:create, :update, :destroy]
  before_action :update_book, only: [:update, :destroy]

  def show
  end

  def create
    @review.book = @book
    @review.user = current_user
    @review.save
    @reviews = @book.reviews
    @book.sum_rate += 1
    @book.sum_point += @review.rate
    @book.save
  end

  def edit
  end

  def update
    @review.update_attributes review_params
    @reviews = @book.reviews
    @book.sum_point += @review.rate
    @book.save
  end

  def destroy
    @review.destroy
    @reviews = @book.reviews
    @book.sum_rate -= 1
    @book.save
  end

  private
  def review_params
    params.require(:review).permit :title, :content, :rate
  end

  def load_support
    @supports = Supports::Book.new @book
  end

  def update_book
    @book.sum_point -= @review.rate
  end
end
