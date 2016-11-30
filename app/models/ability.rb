class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    user ||= User.new
    alias_action :new, :create, :edit, :update, :destroy, to: :crud
    case controller_namespace
    when "Admin"
      if user.admin?
      end
    else
      can :read, User
      can :update, User, id: user.id
      can :read, Book
      can :manage, Mark, user_id: user.id
      can :read, Category
      can :manage, Request, user_id: user.id
    end
  end
end
