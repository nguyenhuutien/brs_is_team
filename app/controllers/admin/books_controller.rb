class Admin::BooksController < Admin::AdminController
  load_and_authorize_resource

  def show
    @categories = Category.all
  end

  def index
    @categories = Category.includes :books
    @q = @books.ransack params[:q]
    @books = @q.result.page(params[:page]).per Settings.per_page
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "book.success"
      @categories = Category.all
    end
  end

  def destroy
    @book.destroy
    @categories = Category.includes :books
    @books = Book.all
    @q = @books.ransack params[:q]
    @books = @q.result.page(params[:page]).per Settings.per_page
  end

  private
  def book_params
    params.require(:book).permit :title, :description, :publish_date, :author,
      :pages, :photo, :category_id
  end
end
