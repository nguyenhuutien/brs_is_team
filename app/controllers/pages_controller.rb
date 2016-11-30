class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :load_data

  def index
  end

  def show
    render template: "pages/#{params[:page]}"
  end

  private
  def load_data
    @feed_back =  FeedBack.new
    if user_signed_in?
     @reviews = current_user.user_reviews
     @books = current_user.favorite_books
    else
      @reviews = Review.all
      @books = Book.all
    end
  end
end