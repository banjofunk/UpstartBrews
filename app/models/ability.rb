class Ability
  include CanCan::Ability

  def initialize(current_user)
    can :create, User
    can :view, Batch
    if current_user
      can :manage, :all if current_user.has_role?(:admin)
      can :manage, User, :id => current_user.id
      can :manage, :admin if current_user.has_role?(:admin)
      can :manage, Batch
      can :manage, BatchReading
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
