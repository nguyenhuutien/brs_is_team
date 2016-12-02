class FavoriteAuthorsController < ApplicationController
  load_and_authorize_resource

  def create
    @favorite_author.user = current_user
    @favorite_author.save
    @author = @favorite_author.author
  end

  def destroy
    @author = @favorite_author.author
    @favorite_author.destroy
  end

  private
  def favorite_author_params
    params.require(:favorite_author).permit :author_id
  end
end
