class ListBooksController < ApplicationController
  load_and_authorize_resource :user

  def index
    if params[:book_status]
      @books ||= @user.send(params[:book_status]).page(params[:page]).
        per Settings.per_page
      @title ||= params[:book_status]
    else
      author = Author.find_by id: params[:author_id]
      if author
        @books ||= author.books.page(params[:page]).per Settings.per_page
        @title ||= author.name
      end
    end
  end
end