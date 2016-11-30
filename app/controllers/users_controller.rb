class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @active = if current_user.following? @user
      current_user.active_relationships.find_by followed_id: @user.id
    else
      current_user.active_relationships.build
    end
  end

  def edit
  end

  def update
    if @user.update_with_password user_params
      flash[:success] = t "user.update_success"
    else
      flash[:danger] = t "user.update_fail"
    end
    redirect_to @user
  end

  private
  def user_params
    params.require(:user).permit :email, :name, :password, :password_confirmation,
      :current_password, :image
  end
end
