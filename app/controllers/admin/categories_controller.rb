class Admin::CategoriesController < Admin::AdminController
  load_and_authorize_resource

  def index
    @categories = Category.includes :books
    @q = @categories.ransack params[:q]
    @categories = @q.result.page(params[:page]).per Settings.per_page
  end
end
