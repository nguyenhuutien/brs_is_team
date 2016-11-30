class MarksController < ApplicationController
  load_and_authorize_resource

  def update
    @mark.update_attributes mark_params
  end

  private
  def mark_params
    params.require(:mark).permit :mark_read, :favorite
  end
end