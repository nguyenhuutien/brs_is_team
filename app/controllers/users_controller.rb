class UsersController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def update
    if @user.update_with_password user_params
      flash[:success] = "success"
    else
      flash[:danger] = "Fail"
    end
    redirect_to @user
  end

  private
  def user_params
    params.require(:user).permit :email, :name, :password, :password_confirmation, :current_password
  end
end
