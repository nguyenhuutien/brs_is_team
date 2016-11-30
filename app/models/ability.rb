class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    user ||= User.new
    alias_action :new, :create, :edit, :update, :destroy, to: :crud
    case controller_namespace
    when "Admin"
      if user.admin?
        can :manage, :all
        cannot :crud, User do |other_user|
          other_user.admin?
        end
      end
    else
      unless user.admin?
        can :read, User
        can :update, User, id: user.id
        can :read, Book
        can :read, Category
        can :manage, Request, user_id: user.id
        can :destroy, Like, user_id: user.id
        can :manage, Review, user_id: user.id
      end
    end
  end
end
