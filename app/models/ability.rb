class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, User
    can :view, Batch
    if user
      can :poop, User
      can :manage, User
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
