class ReviewsController < ApplicationController
  load_and_authorize_resource :book
  load_and_authorize_resource

  def create
    @review.book = @book
    @review.user = current_user
    @review.save
    @reviews = @book.reviews
  end

  def edit
  end

  def update
    @review.update_attributes review_params
    @reviews = @book.reviews
  end

  def destroy
    @review.destroy
    @reviews = @book.reviews
  end

  private
  def review_params
    params.require(:review).permit :title, :content, :rate
  end
end
