class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @q = @category.books.ransack params[:q]
    @books = @q.result.page(params[:page]).per Settings.per_page
  end
end
