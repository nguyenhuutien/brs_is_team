class CommentsController < ApplicationController
  load_and_authorize_resource :review
  load_and_authorize_resource

  def new
  end

  def create
    @comment.review = @review
    @comment.user = current_user
    @comment.save
    @comments = @review.comments
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end
end