class RequestsController < ApplicationController
  load_and_authorize_resource only: [:new, :create, :destroy]

  def index
    @requests = current_user.requests.page(params[:page]).per Settings.per_page
  end

  def new
  end

  def create
    if @request.save
      flash.now[:success] = t "request.success"
      redirect_to user_requests_path(current_user)
    else
      render :new
    end
  end

  def destroy
    if @request.destroy
      flash[:success] = t "request.success"
    else
      flash[:danger] = t "request.danger"
    end
    @requests = current_user.requests.page(params[:page]).per Settings.per_page
  end

  private
  def request_params
    params.require(:request).permit :book_title, :book_publish_date,
      :book_author
  end
end
