class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @books = (params[:type].nil? || params[:type] == "all") ? @books :
      @books.send("#{params[:type]}", current_user.id)
    @q = @category.books.ransack params[:q]
    @books = @q.result.page(params[:page]).per Settings.per_page
  end
end
