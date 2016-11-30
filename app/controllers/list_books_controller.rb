class ListBooksController < ApplicationController
  load_and_authorize_resource :user

  def index
    @books ||= @user.send(params[:book_status]).page(params[:page]).per Settings.per_page
    @title = params[:book_status]
  end
end