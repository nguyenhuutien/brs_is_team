class AuthorsController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:type] == "favorite"
      @authors = current_user.list_favorite_authors
    end
    @q = @authors.ransack params[:q]
    @authors = @q.result.page(params[:page]).per Settings.per_page
  end

  def show
    @books = @author.books.page(params[:page]).per Settings.per_page
    @favorite_author = current_user.favorite_authors.find_by author_id: @author.id
  end
end
