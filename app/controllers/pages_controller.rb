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
      @reviews = current_user.user_reviews.page(params[:page]).
        per(Settings.per_page)
     @books = current_user.list_favorite.limit(6)
    end
    @most_books = Book.most_books
    @activities = PublicActivity::Activity.all.order(created_at: :desc)
  end
end
