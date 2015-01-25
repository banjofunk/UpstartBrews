class Ability
  include CanCan::Ability

  def initialize(current_user)
    can :create, User
    if current_user
      can :read, Batch
      can :manage, User, :id => current_user.id

      if current_user.has_role?(:admin)
        can :manage, :all
        can :manage, :admin
      end

      if current_user.has_role?(:brewer)
        can :manage, Fermenter
        can :manage, Batch
        can :manage, BatchReading
        can :manage, BatchProcess
      end

      if current_user.has_role?(:sales)
        can :read, Fermenter
        can :read, Batch
        can :read, BatchReading
        can :read, BatchProcess
      end
    end
  end

  def as_json
    abilities = {}
    rules.each do |rule|
      rule.actions.each do |action|
        abilities[action] ||= {}
        rule.subjects.map {|subject| abilities[action][subject] = rule.base_behavior}
      end
    end
    abilities
  end
end
