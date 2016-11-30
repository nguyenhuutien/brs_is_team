class Admin::CategoriesController < Admin::AdminController
  load_and_authorize_resource

  def index
    @categories = @categories.includes :books
    @q = @categories.ransack params[:q]
    @categories = @q.result.page(params[:page]).per Settings.per_page
  end

  def show
    @q = @category.books.ransack params[:q]
    @books = @q.result.page(params[:page]).per Settings.per_page
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "category.success"
      redirect_to admin_categories_path
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t "category.success"
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
