class MarksController < ApplicationController
  authorize_resource
  before_action :load_mark

  def update
    @mark_before = @mark.attributes
    @mark.update_attributes mark_params
    create_mark_activity
  end

  private
  def mark_params
    params.require(:mark).permit :mark_read, :favorite
  end

  def load_mark
    @mark = Mark.find_by id: params[:id]
    if @mark.nil?
      flash[:danger] = t :danger
      redirect_to root_path
    end
  end

  def create_mark_activity
    if @mark_before.mark_read != @mark.mark_read
      @mark.book.create_activity key: "#{@mark.mark_read}", owner: @mark.user
    else
      @mark.bookcreate_activity key: "favorite" , owner: @mark.user
    end
  end
end
