class Admin::BooksController < Admin::AdminController
  load_and_authorize_resource

  def index
    @categories = Category.includes :books
    @q = @books.ransack params[:q]
    @books = @q.result.page(params[:page]).per Settings.per_page
  end
end