class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    user ||= User.new
    alias_action :new, :create, :edit, :update, :destroy, to: :crud
    alias_action :new, :create, :show, :index, to: :crub1
    alias_action :edit, :update, :destroy, to: :crub2
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
        can :crub1, Review
        can :crub2, Review, user_id: user.id
        can :crub1, Comment
        can :crub2, Comment, user_id: user.id
        can :crub1, FavoriteAuthor
        can :crub2, FavoriteAuthor, user_id: user.id
      end
    end
  end
end
