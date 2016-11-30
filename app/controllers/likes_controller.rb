class LikesController < ApplicationController
  before_action :load_data

  def create
    @like = @activity.likes.build
    @like.user = current_user
    @like.save
  end

  def destroy
    @like = @activity.likes.find_by id: params[:id]
    @like.destroy
    @activity.likes.build
  end

  private
  def load_data
    @activity = Activity.find_by id: params[:activity_id]
  end
end
