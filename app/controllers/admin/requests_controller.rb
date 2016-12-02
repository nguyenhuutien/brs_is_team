class Admin::RequestsController < Admin::AdminController
  load_and_authorize_resource

  def index
    @q = @requests.ransack params[:q]
    @requests = @q.result.page(params[:page]).per Settings.per_page
  end

  def update
    @request.update_attributes request_params
    @requests = Request.all.page(params[:page]).per Settings.per_page
    @q = @requests.ransack params[:q]
    @requests = @q.result.page(params[:page]).per Settings.per_page
  end

  private
  def request_params
    params.require(:request).permit :status
  end
end
