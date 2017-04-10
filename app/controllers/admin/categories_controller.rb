class Admin::CategoriesController < Admin::AdminController
  load_and_authorize_resource

  def new
  end

  def create
    if @category.save
      @categories = @categories.includes :books
      @q = @categories.ransack params[:q]
      @categories = @q.result.page(params[:page]).per Settings.per_page
    end
  end

  def index
    @categories = @categories.includes :books
    @q = @categories.ransack params[:q]
    @categories = @q.result.page(params[:page]).per Settings.per_page
  end

  def show
    @q = @category.books.ransack params[:q]
    @books = @q.result.page(params[:page]).per Settings.per_page
  end

  def new
  end

  def create
    if @category.save
      @categories = @categories.includes :books
      @q = @categories.ransack params[:q]
      @categories = @q.result.page(params[:page]).per Settings.per_page
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      @categories = @categories.includes :books
      @q = @categories.ransack params[:q]
      @categories = @q.result.page(params[:page]).per Settings.per_page
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
