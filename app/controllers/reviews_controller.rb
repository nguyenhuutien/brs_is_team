class ReviewsController < ApplicationController
  load_and_authorize_resource :book
  load_and_authorize_resource

  def create
    @review.book = @book
    @review.save
    @reviews = @book.reviews
  end

  private
  def review_params
    params.require(:review).permit :title, :content, :rate
  end
end
