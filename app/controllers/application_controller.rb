class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include CanCan::ControllerAdditions

  before_action :authenticate_user!
  before_action :load_categories, :load_notification

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = exception.message
    redirect_to root_path
  end

  def after_sign_in_path_for resource
    current_user.try(:admin?) ? admin_root_path : root_path
  end

  private
  def load_categories
    @categories = Category.all
  end

  def current_ability
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join('/').camelize
    Ability.new current_user, controller_namespace
  end

  def load_notification
    @notifications = current_user.notifications if current_user
  end
end
