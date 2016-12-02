class Admin::BooksController < Admin::AdminController
  load_and_authorize_resource

  def index
    @categories = Category.includes :books
    @q = @books.ransack params[:q]
    @books = @q.result.page(params[:page]).per Settings.per_page
  end

  def show
    @categories = Category.all
  end

  def new
    @category = Category.find_by(id: params[:category_id]) if params[:category_id]
    @book.authors.build
    @authors = Author.all
  end

  def create
    correct_params = correct_book_params
    if correct_params
      @book = Book.new correct_params
      if @book.save
        @authors.each do |author|
          @book.book_authors.create author_id: author
        end
        @categories = Category.all
        @books = Book.all
        @categories = Category.includes :books
        @q = @books.ransack params[:q]
        @books = @q.result.page(params[:page]).per Settings.per_page
      end
    end
  end

  def edit
    @authors = Author.all
  end

  def update
    correct_params = correct_book_params
    if correct_params && @book.update_attributes(correct_params)
      @categories = Category.all
      @books = Book.all
      @categories = Category.includes :books
      @q = @books.ransack params[:q]
      @books = @q.result.page(params[:page]).per Settings.per_page
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
    params.require(:book).permit :title, :description, :publish_date, :pages,
      :photo, :category_id, authors_attributes: [:id, :name, :_destroy]
  end

  def correct_book_params
    @authors = Array.new
    check_book_params = book_params
    params_book_author = book_params[:authors_attributes]
    params_author = params[:author]
    if params_author
      params_author.each do |id|
        if params[id][:_destroy] == "0" && params_book_author[id][:_destroy] == "0"
          author = Author.find_by name: params_author[id]
          if author
            check_book_params[:authors_attributes][id][:name] = author.name
          else
            check_book_params[:authors_attributes] = check_book_params[:authors_attributes].without id
          end
        elsif params_book_author[id][:_destroy] == "1"
          params_book_author.without id
        end
      end
    end

    params_book_author = check_book_params[:authors_attributes].to_a
    if params_book_author.size != 1
      (0...params_book_author.size).each do |i|
        ((i+1)...params_book_author.size).each do |j|
          if params_book_author[i][1][:name] == params_book_author[j][1][:name]
            @book.errors.add :some_thing, "went wrong"
            return false
          end
        end
      end
    end

    params_book_author = check_book_params[:authors_attributes]
    params_book_author.each do |author|
      if (aut = Author.find_by name: params_book_author[author][:name])
        @authors.push aut.id
        check_book_params[:authors_attributes] = check_book_params[:authors_attributes].without author
      end
    end
    check_book_params
  end
end
