class LikesController < ApplicationController
  load_resource :review
  load_resource
  authorize_resource only: :destroy

  def create
    @like.review = @review
    @like.user = current_user
    @like.save
  end

  def destroy
    @like.destroy
    @review.likes.build
  end
end
