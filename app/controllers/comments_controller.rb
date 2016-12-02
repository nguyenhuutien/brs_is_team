class CommentsController < ApplicationController
  load_and_authorize_resource :review
  load_and_authorize_resource

  def new
    @parent = Comment.find_by id:  comment_params[:reply_id]
  end

  def create
    @comment.review = @review
    @comment.user = current_user
    @comment.save
    @comments = @review.review_comments
  end

  def edit
    @comments = @review.review_comments
  end

  def update
    @comment.update_attributes comment_params
    @comments = @review.review_comments
  end

  def destroy
    @comment.destroy
    @comments = @review.review_comments
  end

  private
  def comment_params
    params.require(:comment).permit :content, :parent_id, :reply_id
  end
end
