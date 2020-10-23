# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    #Definición auxiliar de USER
    user ||= User.new #Usuario no logeado
    # Define abilities for the passed in user here. For example:
    if user.admin?
      can :manage, Proyecto
      can :manage, User
    elsif user.lider?
      can :read, Proyecto
      can :update, Proyecto
      can :manage, Colaborador
      can :manage, Requerimientos::Requerimiento
      can :manage, Lanzamiento::Meta #do |meta|
        #meta.try(colaborador: { user_id: { :id => user.id } }) == meta
      #end
    elsif user.usuario?
      can :read, Proyecto, user_id: user.id
      #can :update, Proyecto, user_id: user.id
    end
    
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
