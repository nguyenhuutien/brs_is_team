class Admin::UsersController < Admin::AdminController
  authorize_resource

  def index
    @users = User.all_users
    @q = @users.ransack params[:q]
    @users = @q.result.page(params[:page]).per Settings.per_page
  end

  def show
  end

  def destroy
    @user.destroy
    @users = User.all_users
    @q = @users.ransack params[:q]
    @users = @q.result.page(params[:page]).per Settings.per_page
  end
end