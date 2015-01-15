class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, User
    if user
      can :manage, Batch
    end
  end
end
