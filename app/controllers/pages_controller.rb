class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :load_data
  before_action :check_admin

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
      @favorite_books ||= current_user.list_favorite.limit(Settings.limit_element)
    end
    @most_books ||= Book.most_books
    @activities ||= PublicActivity::Activity.all.order(created_at: :desc)
  end

  def check_admin
    redirect_to admin_root_path if current_user.try :admin?
  end
end
